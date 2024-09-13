import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mindwrite/core/resources/data_state.dart';
import 'package:mindwrite/features/home_feature/data/model/note_model.dart';
import 'package:mindwrite/features/home_feature/domain/entities/note_model_entity.dart';
import 'package:mindwrite/features/home_feature/domain/usecases/change_archive_usecase.dart';

import 'package:mindwrite/features/home_feature/domain/usecases/load_notes_usecase.dart';
import 'package:mindwrite/features/home_feature/domain/usecases/pinned_notes_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  List<NoteModel> allLoadedNotes;
  List<NoteModel>? pinnedNotes = [];
  LoadAllArchivedUsecase loadNotesUsecase;
  LoadPinnedNotesUsecase loadPinnedNotesUsecase;
  ChangeArchiveUsecase changeArchiveUsecase;

  HomeBloc(this.allLoadedNotes, this.loadNotesUsecase,
      this.loadPinnedNotesUsecase, this.changeArchiveUsecase)
      : super(HomeInitial(allLoadedNotes)) {
    on<GetNotesEvent>((event, emit) async {
      emit(const HomeLoading("loading"));
      final result = await loadNotesUsecase.call();
      pinnedNotes!.clear();
      if (result is DataSuccess<List<NoteModelEntity>>) {
        pinnedNotes = await loadPinnedNotesUsecase(result);
        emit(HomeLoaded(result.data!, pinnedNotes!));
      } else if (result is DataFailed) {
        emit(HomeLoading(result.error!));
      }
    });
    on<ToggleArchiveEvent>((event, emit) async {
      emit(const HomeLoading("loading"));
      print("inside bloc");
      print(event.note.archived);

      await changeArchiveUsecase.call(event.note);

      print("inside bloc");
      // Remove the note from the list
      allLoadedNotes.remove(event.note);
      final result = await loadNotesUsecase.call();
      print(result.data);

      if (result is DataSuccess<List<NoteModelEntity>>) {
        pinnedNotes = await loadPinnedNotesUsecase(result);
        print(result.data);

        emit(HomeLoaded(result.data!, pinnedNotes!));
      } else if (result is DataFailed) {
        emit(HomeLoadFailed(result.error!));
      }
    });
  }
}
