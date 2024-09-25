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
import 'package:mindwrite/features/label_feature/presentation/bloc/label_bloc.dart';
import 'package:mindwrite/features/shared_bloc/data/model/background_model.dart';
import 'package:mindwrite/features/shared_bloc/data/model/note_model.dart';
import 'package:mindwrite/features/shared_bloc/domain/usecases/change_archive_usecase.dart';
import 'package:mindwrite/features/shared_bloc/domain/usecases/change_paletter_usecase.dart';
import 'package:mindwrite/features/shared_bloc/domain/usecases/delete_note_usecase.dart';
import 'package:mindwrite/features/shared_bloc/domain/usecases/pin_note_usecase.dart';
import 'package:mindwrite/features/shared_bloc/domain/usecases/restore_note_usecase.dart';
import 'package:mindwrite/locator.dart';

part 'shared_event.dart';
part 'shared_state.dart';

class SharedBloc extends Bloc<SharedEvent, SharedState> {
  bool isSelectionMode = false;
  List<NoteModel> selectedItems;
  ListModeEnum listMode = ListModeEnum.multiple;
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
  ) : super(SharedInitial(selectedItems, isSelectionMode, listMode)) {
    /// when have long press on notes, this will comes up
    on<LongPressItem>((event, emit) {
      emit(SharedLoading());

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
      emit(SharedInitial(selectedItems, isSelectionMode, listMode));
    });

    on<TapItem>((event, emit) {
      emit(SharedLoading());

      if (isSelectionMode) {
        if (selectedItems.contains(event.tappedNoteModel)) {
          selectedItems.remove(event.tappedNoteModel);
        } else {
          selectedItems.add(event.tappedNoteModel);
        }
        if (selectedItems.isEmpty) {
          isSelectionMode = false;
        }
        emit(SharedInitial(selectedItems, isSelectionMode, listMode));
      }
    });

    on<ExitSelectionMode>((event, emit) {
      emit(SharedLoading());
      isSelectionMode = false;
      selectedItems.clear();

      emit(SharedInitial(const [], isSelectionMode, listMode));
    });

    on<DeleteNoteEvent>((event, emit) async {
      emit(SharedLoading());

      var result = await deleteNoteUsecase(selectedItems);
      if (result is DataSuccess<List<NoteModel>>) {
        isSelectionMode = false;
        selectedItems.clear();
        emit(SharedInitial(selectedItems, isSelectionMode, listMode));
        locator<ArchiveBloc>().add(const GetAllArchive());
        locator<HomeBloc>().add(LoadAllNotes());
      } else if (result is DataFailed) {
        emit(SharedLoadFailed());
      }
    });

    on<RestoreNoteEvent>((event, emit) async {
      emit(SharedLoading());
      var result = await restoreDeletedNoteUsecase.call(selectedItems);
      if (result is DataSuccess<List<NoteModel>>) {
        isSelectionMode = false;
        selectedItems.clear();

        emit(SharedInitial(selectedItems, isSelectionMode, listMode));
        locator<DeleteBloc>().add(const GetAllDeleted());
      } else if (result is DataFailed) {
        emit(SharedLoadFailed());
      }
    });

    on<ToggleArchiveEvent>((event, emit) async {
      var result = await toggleArchiveUsecase(event.notes);
      locator<HomeBloc>().add(LoadAllNotes());
      locator<ArchiveBloc>().add(const GetAllArchive());

      if (result is DataSuccess<NoteModel>) {
        emit(SharedInitial(const [], false, listMode));
      } else if (result is DataFailed) {
        emit(SharedLoadFailed());
      }
    });

    on<PinNotesEvent>((event, emit) async {
      emit(SharedLoading());
      var result = await pinToggleNoteUsecase(selectedItems);
      if (result is DataSuccess<List<NoteModel>>) {
        isSelectionMode = false;
        selectedItems.clear();

        emit(SharedInitial(selectedItems, isSelectionMode, listMode));
        locator<HomeBloc>().add(LoadAllNotes());
      } else if (result is DataFailed) {
        emit(SharedLoadFailed());
      }
    });
    on<ChangePaletteNoteEvent>((event, emit) async {
      emit(SharedLoading());

      for (int i = 0; i < selectedItems.length; i++) {
        selectedItems[i] = selectedItems[i].copyWith(
          noteBackground: BackgroundModel(
              color: event.selectedColor,
              backgroundPath: selectedItems[i].noteBackground!.backgroundPath),
        );
      }

      var result = await changePaletteNoteEvent(selectedItems);
      if (result is DataSuccess<List<NoteModel>>) {
        isSelectionMode = false;
        selectedItems.clear();

        emit(SharedInitial(selectedItems, isSelectionMode, listMode));
        locator<HomeBloc>().add(LoadAllNotes());
      } else if (result is DataFailed) {
        emit(SharedLoadFailed());
      }
    });

    on<ChangeCrossAxisCountEvent>((event, emit) async {
      emit(SharedLoading());
      if (listMode == ListModeEnum.multiple) {
        listMode = ListModeEnum.single;
      } else {
        listMode = ListModeEnum.multiple;
      }
      emit(SharedInitial(selectedItems, isSelectionMode, listMode));
    });
  }
}
