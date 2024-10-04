import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mindwrite/features/shared_bloc/data/model/background_model.dart';
import 'package:mindwrite/features/shared_bloc/data/model/note_model.dart';
import 'package:mindwrite/locator.dart';

class SharedLocalDatabase {
  Box<NoteModel> noteBox = locator(instanceName: "note_box");
  Box appBox = locator(instanceName: "app_box");

  Future<ThemeMode> getThemeMode() async {
    bool isDarkMode = await appBox.get("isDarkMode") ?? false;
    if (isDarkMode) {
      return ThemeMode.dark;
    }
    return ThemeMode.light;
  }

  Future<ThemeMode> toggleDarkMode() async {
    bool isDarkMode = appBox.get("isDarkMode", defaultValue: false);

    isDarkMode = !isDarkMode;

    await appBox.put("isDarkMode", isDarkMode);

    return isDarkMode ? ThemeMode.dark : ThemeMode.light;
  }

  Future<List<NoteModel>?> toggleNoteArchiveToBox(List<NoteModel> notes) async {
    List<NoteModel> updatedNotes = [];

    for (var note in notes) {
      NoteModel? result = noteBox.get(note.id);

      if (result != null) {
        NoteModel updatedNote = result.copyWith(archived: !note.archived);

        await noteBox.put(result.id, updatedNote);

        updatedNotes.add(updatedNote);
      }
    }

    return updatedNotes;
  }

  Future<void> pinToggleToBox(List<NoteModel> notes) async {
    List<NoteModel> existingNotes = noteBox.values.toList();

    for (NoteModel noteToPin in notes) {
      NoteModel? existingNote = existingNotes.firstWhere(
        (element) => element.id == noteToPin.id,
      );

      NoteModel updatedNote = existingNote.copyWith(
        pin: !existingNote.pin,
        archived: false,
      );

      await noteBox.put(updatedNote.id, updatedNote);
    }
  }

  Future<void> changeNotePaletteToBox(List<NoteModel> notes) async {
    List<NoteModel> existingNotes = noteBox.values.toList();

    for (NoteModel noteToPin in notes) {
      NoteModel? existingNote = existingNotes.firstWhere(
        (element) => element.id == noteToPin.id,
      );

      NoteModel updatedNote = existingNote.copyWith(
        noteBackground: BackgroundModel(
          lightColor: noteToPin.noteBackground!.lightColor,
          darkColor: noteToPin.noteBackground!.darkColor,
          darkBackgroundPath: noteToPin.noteBackground!.darkBackgroundPath,
          lightBackgroundPath: noteToPin.noteBackground!.lightBackgroundPath,
        ),
      );

      await noteBox.put(updatedNote.id, updatedNote);
    }
  }

  Future<void> deleteNoteFromBox(List<NoteModel> noteList) async {
    List<NoteModel> existingNotes = noteBox.values.toList();

    for (NoteModel noteToRestore in noteList) {
      NoteModel? existingNote = existingNotes.firstWhere(
        (element) => element.id == noteToRestore.id,
      );

      NoteModel updatedNote = existingNote.copyWith(isDeleted: true);

      await noteBox.put(updatedNote.id, updatedNote);
    }
  }

  Future<void> restoreNoteFromBox(List<NoteModel> noteList) async {
    List<NoteModel> existingNotes = noteBox.values.toList();

    for (NoteModel noteToRestore in noteList) {
      NoteModel? existingNote = existingNotes.firstWhere(
        (element) => element.id == noteToRestore.id,
      );

      NoteModel updatedNote = existingNote.copyWith(isDeleted: false);

      await noteBox.put(updatedNote.id, updatedNote);
    }
  }
}
