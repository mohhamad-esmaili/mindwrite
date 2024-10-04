import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindwrite/core/enums/listmode_enum.dart';
import 'package:mindwrite/core/resources/data_state.dart';
import 'package:mindwrite/features/archive_feature/presentation/bloc/archive_bloc.dart';
import 'package:mindwrite/features/archive_feature/presentation/bloc/archive_event.dart';
import 'package:mindwrite/features/delete_feature/presentation/bloc/delete_bloc.dart';
import 'package:mindwrite/features/delete_feature/presentation/bloc/delete_event.dart';
import 'package:mindwrite/features/home_feature/presentation/bloc/home_bloc.dart';
import 'package:mindwrite/features/shared_bloc/data/model/background_model.dart';
import 'package:mindwrite/features/shared_bloc/data/model/note_model.dart';
import 'package:mindwrite/features/shared_bloc/domain/usecases/change_archive_usecase.dart';
import 'package:mindwrite/features/shared_bloc/domain/usecases/change_paletter_usecase.dart';
import 'package:mindwrite/features/shared_bloc/domain/usecases/delete_note_usecase.dart';
import 'package:mindwrite/features/shared_bloc/domain/usecases/load_theme_usecase.dart';
import 'package:mindwrite/features/shared_bloc/domain/usecases/pin_note_usecase.dart';
import 'package:mindwrite/features/shared_bloc/domain/usecases/restore_note_usecase.dart';
import 'package:mindwrite/features/shared_bloc/domain/usecases/toggle_theme_usecase.dart';
import 'package:mindwrite/locator.dart';

part 'shared_event.dart';
part 'shared_state.dart';

class SharedBloc extends Bloc<SharedEvent, SharedState> {
  bool isSelectionMode = false;
  List<NoteModel> selectedItems;
  ListModeEnum listMode = ListModeEnum.multiple;
  ThemeMode themeMode = ThemeMode.dark;
  LoadThemeUsecase loadThemeUsecase;
  ToggleThemeUsecase toggleThemeUsecase;
  ToggleArchiveUsecase toggleArchiveUsecase;
  DeleteNoteUsecase deleteNoteUsecase;
  RestoreDeletedNoteUsecase restoreDeletedNoteUsecase;
  PinToggleNoteUsecase pinToggleNoteUsecase;
  ChangePaletterUsecase changePaletteNoteEvent;
  SharedBloc(
    this.isSelectionMode,
    this.selectedItems,
    this.listMode,
    this.toggleArchiveUsecase,
    this.deleteNoteUsecase,
    this.restoreDeletedNoteUsecase,
    this.pinToggleNoteUsecase,
    this.changePaletteNoteEvent,
    this.loadThemeUsecase,
    this.toggleThemeUsecase,
  ) : super(SharedInitial(
            selectedItems, isSelectionMode, listMode, ThemeMode.dark)) {
    on<LoadThemeMode>((event, emit) async {
      emit(const SharedLoading());
      final result = await loadThemeUsecase();

      if (result is DataSuccess<ThemeMode>) {
        themeMode = result.data!;
        emit(
            SharedInitial(selectedItems, isSelectionMode, listMode, themeMode));
      } else {
        emit(const SharedLoadFailed());
      }
    });

    on<ToggleTheme>((event, emit) async {
      emit(const SharedLoading());
      final newThemeMode = await toggleThemeUsecase();

      themeMode = newThemeMode.data!;
      emit(SharedInitial(selectedItems, isSelectionMode, listMode, themeMode));
    });

    /// when have long press on notes, this will comes up
    on<LongPressItem>((event, emit) {
      emit(const SharedLoading());

      if (!selectedItems.contains(event.longNoteModel)) {
        isSelectionMode = true;

        selectedItems.add(event.longNoteModel);
      } else {
        isSelectionMode = false;
        selectedItems.remove(event.longNoteModel);
      }
      if (selectedItems.isEmpty) {
        isSelectionMode = false;
      }
      emit(SharedInitial(selectedItems, isSelectionMode, listMode, themeMode));
    });

    on<TapItem>((event, emit) {
      emit(const SharedLoading());

      if (isSelectionMode) {
        if (selectedItems.contains(event.tappedNoteModel)) {
          selectedItems.remove(event.tappedNoteModel);
        } else {
          selectedItems.add(event.tappedNoteModel);
        }
        if (selectedItems.isEmpty) {
          isSelectionMode = false;
        }
        emit(
            SharedInitial(selectedItems, isSelectionMode, listMode, themeMode));
      }
    });

    on<ExitSelectionMode>((event, emit) {
      emit(const SharedLoading());
      isSelectionMode = false;
      selectedItems.clear();

      emit(SharedInitial(const [], isSelectionMode, listMode, themeMode));
    });

    on<DeleteNoteEvent>((event, emit) async {
      emit(const SharedLoading());

      var result = await deleteNoteUsecase(selectedItems);
      if (result is DataSuccess<List<NoteModel>>) {
        isSelectionMode = false;
        selectedItems.clear();
        emit(
            SharedInitial(selectedItems, isSelectionMode, listMode, themeMode));
        locator<ArchiveBloc>().add(const GetAllArchive());
        locator<HomeBloc>().add(LoadAllNotes());
      } else if (result is DataFailed) {
        emit(const SharedLoadFailed());
      }
    });

    on<RestoreNoteEvent>((event, emit) async {
      emit(const SharedLoading());
      var result = await restoreDeletedNoteUsecase.call(selectedItems);
      if (result is DataSuccess<List<NoteModel>>) {
        isSelectionMode = false;
        selectedItems.clear();

        emit(
            SharedInitial(selectedItems, isSelectionMode, listMode, themeMode));
        locator<DeleteBloc>().add(const GetAllDeleted());
      } else if (result is DataFailed) {
        emit(const SharedLoadFailed());
      }
    });

    on<ToggleArchiveEvent>((event, emit) async {
      var result = await toggleArchiveUsecase(event.notes);
      locator<HomeBloc>().add(LoadAllNotes());
      locator<ArchiveBloc>().add(const GetAllArchive());

      if (result is DataSuccess<NoteModel>) {
        emit(SharedInitial(const [], false, listMode, themeMode));
      } else if (result is DataFailed) {
        emit(const SharedLoadFailed());
      }
    });

    on<PinNotesEvent>((event, emit) async {
      emit(const SharedLoading());
      var result = await pinToggleNoteUsecase(selectedItems);
      if (result is DataSuccess<List<NoteModel>>) {
        isSelectionMode = false;
        selectedItems.clear();

        emit(
            SharedInitial(selectedItems, isSelectionMode, listMode, themeMode));
        locator<HomeBloc>().add(LoadAllNotes());
      } else if (result is DataFailed) {
        emit(const SharedLoadFailed());
      }
    });
    on<ChangePaletteNoteEvent>((event, emit) async {
      emit(const SharedLoading());

      for (int i = 0; i < selectedItems.length; i++) {
        selectedItems[i] = selectedItems[i].copyWith(
          noteBackground: BackgroundModel(
            lightColor: event.selectedLightColor,
            darkColor: event.selectedDarkColor,
            lightBackgroundPath:
                selectedItems[i].noteBackground!.lightBackgroundPath,
            darkBackgroundPath:
                selectedItems[i].noteBackground!.darkBackgroundPath,
          ),
        );
      }

      var result = await changePaletteNoteEvent(selectedItems);
      if (result is DataSuccess<List<NoteModel>>) {
        isSelectionMode = false;
        selectedItems.clear();

        emit(
            SharedInitial(selectedItems, isSelectionMode, listMode, themeMode));
        locator<HomeBloc>().add(LoadAllNotes());
      } else if (result is DataFailed) {
        emit(const SharedLoadFailed());
      }
    });

    on<ChangeCrossAxisCountEvent>((event, emit) async {
      emit(const SharedLoading());
      if (listMode == ListModeEnum.multiple) {
        listMode = ListModeEnum.single;
      } else {
        listMode = ListModeEnum.multiple;
      }
      emit(SharedInitial(selectedItems, isSelectionMode, listMode, themeMode));
    });
  }
}
