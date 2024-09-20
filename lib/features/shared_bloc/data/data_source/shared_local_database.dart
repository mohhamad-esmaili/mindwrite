import 'package:hive_flutter/hive_flutter.dart';
import 'package:mindwrite/features/shared_bloc/data/model/note_model.dart';
import 'package:mindwrite/locator.dart';

class SharedLocalDatabase {
  Box<NoteModel> noteBox = locator();

  Future<NoteModel?> toggleNoteArchiveToBox(NoteModel note) async {
    NoteModel? result = noteBox.get(note.id);

    if (result != null) {
      NoteModel updatedNote = result.copyWith(archived: !note.archived);

      await noteBox.put(result.id, updatedNote);
    } else {}
    return result;
  }

  Future<void> pinToggleToBox(List<NoteModel> notes) async {
    List<NoteModel> existingNotes = noteBox.values.toList();

    for (NoteModel noteToPin in notes) {
      NoteModel? existingNote = existingNotes.firstWhere(
        (element) => element.id == noteToPin.id,
      );

      NoteModel updatedNote = existingNote.copyWith(pin: !existingNote.pin);

      await noteBox.put(updatedNote.id, updatedNote);
    }
  }

  Future<void> deleteNoteFromBox(List<NoteModel> noteList) async {
    // Fetch the existing notes from Hive
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
