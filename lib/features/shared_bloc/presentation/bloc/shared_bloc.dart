import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindwrite/core/resources/data_state.dart';
import 'package:mindwrite/features/archive_feature/presentation/bloc/archive_bloc.dart';
import 'package:mindwrite/features/archive_feature/presentation/bloc/archive_event.dart';
import 'package:mindwrite/features/delete_feature/presentation/bloc/delete_bloc.dart';
import 'package:mindwrite/features/delete_feature/presentation/bloc/delete_event.dart';
import 'package:mindwrite/features/home_feature/presentation/bloc/home_bloc.dart';
import 'package:mindwrite/features/shared_bloc/data/model/note_model.dart';
import 'package:mindwrite/features/shared_bloc/domain/usecases/change_archive_usecase.dart';
import 'package:mindwrite/features/shared_bloc/domain/usecases/delete_note_usecase.dart';
import 'package:mindwrite/features/shared_bloc/domain/usecases/restore_note_usecase.dart';
import 'package:mindwrite/locator.dart';

part 'shared_event.dart';
part 'shared_state.dart';

class SharedBloc extends Bloc<SharedEvent, SharedState> {
  bool isSelectionMode = false;
  List<NoteModel> selectedItems;
  ToggleArchiveUsecase toggleArchiveUsecase;
  DeleteNoteUsecase deleteNoteUsecase;
  RestoreDeletedNoteUsecase restoreDeletedNoteUsecase;
  SharedBloc(
    this.isSelectionMode,
    this.selectedItems,
    this.toggleArchiveUsecase,
    this.deleteNoteUsecase,
    this.restoreDeletedNoteUsecase,
  ) : super(SharedInitial(selectedItems, isSelectionMode)) {
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
      emit(SharedInitial(selectedItems, isSelectionMode));
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
        emit(SharedInitial(selectedItems, isSelectionMode));
      }
    });

    on<ExitSelectionMode>((event, emit) {
      emit(SharedLoading());
      isSelectionMode = false;
      selectedItems.clear();

      emit(SharedInitial(const [], isSelectionMode));
    });

    on<DeleteNoteEvent>((event, emit) async {
      emit(SharedLoading());
      print(selectedItems);
      var result = await deleteNoteUsecase(selectedItems);
      if (result is DataSuccess<List<NoteModel>>) {
        isSelectionMode = false;
        selectedItems.clear();
        emit(SharedInitial(selectedItems, isSelectionMode));
        locator<ArchiveBloc>().add(const GetAllArchive());
        locator<HomeBloc>().add(GetAllNotesEvent());

        print(selectedItems.length);
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

        emit(SharedInitial(selectedItems, isSelectionMode));
        locator<DeleteBloc>().add(const GetAllDeleted());
      } else if (result is DataFailed) {
        emit(SharedLoadFailed());
      }
    });

    on<ToggleArchiveEvent>((event, emit) async {
      var result = await toggleArchiveUsecase(event.note);
      locator<HomeBloc>().add(GetAllNotesEvent());
      locator<ArchiveBloc>().add(const GetAllArchive());

      if (result is DataSuccess<NoteModel>) {
        emit(const SharedInitial([], false));
      } else if (result is DataFailed) {
        emit(SharedLoadFailed());
      }
    });
  }
}
