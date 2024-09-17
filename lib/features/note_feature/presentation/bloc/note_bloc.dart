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
import 'dart:typed_data';
part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final SaveNoteToBoxUsecase saveUseCase;
  NoteModel note;
  NoteBloc(this.note, this.saveUseCase) : super(NoteInitial(note)) {
    NoteModel defaultNote = note.copyWith(
      title: null,
      description: null,
      lastUpdate: DateTime.now(),
      noteBackground:
          BackgroundModel(color: Colors.transparent, backgroundPath: null),
      id: null,
      pin: false,
      archived: false,
      drawingsList: null,
    );
    on<NoteInitialEvent>((event, emit) {
      note = defaultNote;
      emit(NoteInitial(note));
    });
    on<ChangeNoteColorEvent>((event, emit) {
      print(
          "Event triggered: ${event.selectedColor}, ${event.selectedBackGround}");
      note = note.copyWith(
          noteBackground: BackgroundModel(
        color: event.selectedColor == const Color(0xff131313)
            ? Colors.transparent
            : event.selectedColor,
        backgroundPath: event.selectedBackGround,
      ));
      print(
          "Event triggered: ${note.noteBackground!.color}, ${note.noteBackground!.backgroundPath}");
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

      emit(NoteInitial(note, descriptionLines: event.descriptionLines));
    });

    on<SaveNoteEvent>((event, emit) async {
      const Uuid uuid = Uuid();
      NoteModel updatedId = event.noteModel.copyWith(id: uuid.v4());
      final result = await saveUseCase.call(updatedId);
      if (result is DataSuccess) {
        note = defaultNote;
        emit(NoteInitial(locator<NoteModel>()));
      } else {
        emit(NoteSaveFailed(result.error!));
      }
    });
    on<ChangeDrawingLists>((event, emit) {
      note = note.copyWith(
        drawingsList: (note.drawingsList ?? [])..add(event.drewPaint),
      );

      emit(NoteInitial(note));
    });
    on<RemovePaintEvent>((event, emit) {
      emit(NoteSaving());
      List<Uint8List> initializedPaints = List.from(note.drawingsList!);

      initializedPaints.removeWhere((element) => element == event.drewPaint);
      note = note.copyWith(drawingsList: initializedPaints);

      emit(NoteInitial(note));
    });

    on<ClearNoteDataEvent>((event, emit) {
      note = defaultNote;
      emit(NoteInitial(note));
    });
  }
}
