import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindwrite/core/resources/data_state.dart';
import 'package:mindwrite/features/shared_bloc/data/model/background_model.dart';
import 'package:mindwrite/features/shared_bloc/data/model/note_model.dart';

import 'package:mindwrite/features/note_feature/domain/use_cases/save_note_usecase.dart';
import 'package:mindwrite/locator.dart';
import 'dart:typed_data';

import 'package:uuid/uuid.dart';
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
      noteBackground: BackgroundModel(
        darkColor: Colors.transparent,
        darkBackgroundPath: null,
        lightBackgroundPath: null,
        lightColor: const Color.fromRGBO(244, 247, 252, 1),
      ),
      id: null,
      pin: false,
      archived: false,
      drawingsList: null,
    );

    /// the default state of note at first load
    on<NoteInitialEvent>((event, emit) {
      note = defaultNote;
      emit(NoteInitial(note));
    });

    on<RefreshNoteDataEvent>((event, emit) {
      if (event.refreshedNote != null) {
        note = event.refreshedNote!;
      } else {
        note = defaultNote;
      }

      emit(NoteInitial(note));
    });

    /// change background and note color
    on<ChangeNoteColorEvent>((event, emit) {
      note = note.copyWith(
          noteBackground: BackgroundModel(
        darkColor: event.selectedDarkColor == const Color(0xff131313)
            ? Colors.transparent
            : event.selectedDarkColor,
        lightColor:
            event.selectedLightColor == const Color.fromRGBO(244, 247, 252, 1)
                ? const Color.fromRGBO(244, 247, 252, 1)
                : event.selectedLightColor,
        lightBackgroundPath: event.selectedLightBackGround,
        darkBackgroundPath: event.selectedDarkBackGround,
      ));

      emit(NoteInitial(note));
    });

    /// set note to pinned
    on<ChangeNotePinEvent>((event, emit) {
      note = note.copyWith(pin: event.isPin);
      emit(NoteInitial(note));
    });

    /// send the note to archive
    on<NoteArchiveEvent>((event, emit) {
      note = note.copyWith(archived: event.isArchived);
      emit(NoteInitial(note));
    });

    /// controls textediting controller in page
    on<ChangeNoteEvent>((event, emit) {
      DateTime date = DateTime.now();

      note = note.copyWith(
        title: event.titleTextEditingController,
        description: event.decriptionTextEditingController,
        lastUpdate: date,
      );

      emit(NoteInitial(note, descriptionLines: event.descriptionLines));
    });

    /// save note with new id to avoid conflict
    on<SaveNoteEvent>((event, emit) async {
      NoteModel updatedId = event.noteModel;
      const Uuid uuid = Uuid();
      if (!event.isEditing) {
        updatedId = event.noteModel.copyWith(id: uuid.v4());
      }
      final result = await saveUseCase(updatedId);
      if (result is DataSuccess) {
        note = defaultNote;
        emit(NoteInitial(locator<NoteModel>()));
      } else {
        emit(NoteSaveFailed(result.error!));
      }
    });

    /// add images, draws and picked images to note
    on<ChangeDrawingLists>((event, emit) {
      final updatedList = List<Uint8List>.from(note.drawingsList ?? [])
        ..add(event.drewPaint);
      note = note.copyWith(
        drawingsList: updatedList,
      );
      emit(NoteInitial(note));
    });

    /// remove image from list with button on the corner
    on<RemovePaintEvent>((event, emit) {
      emit(NoteSaving());
      List<Uint8List> initializedPaints = List.from(note.drawingsList!);

      initializedPaints.removeWhere((element) => element == event.drewPaint);
      note = note.copyWith(drawingsList: initializedPaints);

      emit(NoteInitial(note));
    });

    /// set note to default
    on<ClearNoteDataEvent>((event, emit) {
      note = defaultNote;
      emit(NoteInitial(note));
    });
  }
}
