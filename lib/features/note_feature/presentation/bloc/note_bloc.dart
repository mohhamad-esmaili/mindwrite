import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindwrite/core/resources/data_state.dart';
import 'package:mindwrite/features/home_feature/data/model/background_model.dart';
import 'package:mindwrite/features/home_feature/data/model/note_model.dart';

import 'package:mindwrite/features/note_feature/domain/use_cases/save_note_usecase.dart';
import 'package:mindwrite/locator.dart';
import 'package:uuid/uuid.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final SaveNoteToBoxUsecase saveUseCase;
  NoteModel note;
  NoteBloc(this.note, this.saveUseCase) : super(NoteInitial(note)) {
    on<NoteInitialEvent>((event, emit) {
      note = note.copyWith(
        title: null,
        description: null,
        lastUpdate: DateTime.now(),
        noteBackground: BackgroundModel(color: Colors.transparent),
        id: null,
        pin: false,
        archived: false,
      );
      emit(NoteInitial(note));
    });
    on<ChangeNoteColorEvent>((event, emit) {
      note = note.copyWith(
          noteBackground: BackgroundModel(color: event.selectedColor));
      emit(NoteInitial(note));
    });
    on<ChangeNotePinEvent>((event, emit) {
      note = note.copyWith(pin: event.isPin);
      emit(NoteInitial(note));
    });
    on<NoteArchiveEvent>((event, emit) {
      note = note.copyWith(archived: event.isArchived);
      emit(NoteInitial(note));
    });
    on<ChangeNoteEvent>((event, emit) {
      DateTime date = DateTime.now();

      note = note.copyWith(
        title: event.titleTextEditingController,
        description: event.decriptionTextEditingController,
        lastUpdate: date,
      );

      emit(NoteInitial(note));
    });
    on<SaveNoteEvent>((event, emit) async {
      const Uuid _uuid = Uuid();
      NoteModel updatedId = event.noteModel.copyWith(id: _uuid.v4());
      final result = await saveUseCase.call(updatedId);
      if (result is DataSuccess) {
        emit(NoteInitial(locator<NoteModel>()));
      } else {
        emit(NoteSaveFailed(result.error!));
      }
    });
  }
}
