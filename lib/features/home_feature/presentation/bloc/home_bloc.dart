import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mindwrite/core/resources/data_state.dart';
import 'package:mindwrite/features/shared_bloc/data/model/note_model.dart';

import 'package:mindwrite/features/home_feature/domain/usecases/load_notes_usecase.dart';
import 'package:mindwrite/features/home_feature/domain/usecases/pinned_notes_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  List<NoteModel> allLoadedNotes;
  List<NoteModel>? pinnedNotes = [];
  LoadNotesUsecase loadNotesUsecase;
  LoadPinnedNotesUsecase loadPinnedNotesUsecase;

  HomeBloc(
      this.allLoadedNotes, this.loadNotesUsecase, this.loadPinnedNotesUsecase)
      : super(HomeInitial(allLoadedNotes)) {
    on<LoadAllNotes>((event, emit) async {
      emit(const HomeLoading("loading"));
      final result = await loadNotesUsecase();

      pinnedNotes!.clear();
      if (result is DataSuccess<List<NoteModel>>) {
        pinnedNotes = await loadPinnedNotesUsecase(result);
        var noteWithoutPin = result.data!
            .where(
              (element) => element.pin == false,
            )
            .toList();
        allLoadedNotes = noteWithoutPin;
        pinnedNotes = pinnedNotes;
        emit(HomeLoaded(noteWithoutPin, pinnedNotes!));
      } else if (result is DataFailed) {
        emit(HomeLoading(result.error!));
      }
    });
    on<SearchNotesEvent>((event, emit) async {
      emit(const HomeLoading("loading"));
      if (event.searchString.isNotEmpty) {
        List<NoteModel> updateList = [];
        List<NoteModel> updatedPinList = [];
        updateList = allLoadedNotes.where((note) {
          return note.title!.contains(event.searchString);
        }).toList();
        if (pinnedNotes != null) {
          updatedPinList = pinnedNotes!.where((note) {
            return note.title!.contains(event.searchString);
          }).toList();
        }
        emit(HomeLoaded(updateList, updatedPinList));
      } else {
        emit(HomeLoaded(allLoadedNotes, pinnedNotes!));
      }
    });
  }
}
