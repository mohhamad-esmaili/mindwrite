import 'package:hive_flutter/hive_flutter.dart';
import 'package:mindwrite/features/shared_bloc/data/model/note_model.dart';
import 'package:mindwrite/locator.dart';

class HomeLocalDataBase {
  Box<NoteModel> box = locator(instanceName: "note_box");
  Future<List<NoteModel>> getListOfNotes() async {
    List<NoteModel> result = box.values
        .where(
          (element) => element.archived == false && element.isDeleted == false,
        )
        .toList();
    return result;
  }

  Future<void> saveNoteToBox(NoteModel note) async {
    await box.put(note.id, note);
  }
}
