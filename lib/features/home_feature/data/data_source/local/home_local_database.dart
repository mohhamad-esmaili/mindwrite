import 'package:hive_flutter/hive_flutter.dart';
import 'package:mindwrite/features/home_feature/data/model/note_model.dart';
import 'package:mindwrite/locator.dart';

class HomeLocalDataBase {
  Box<NoteModel> box = locator();
  Future<List<NoteModel>> getListOfNotes() async {
    List<NoteModel> result =
        box.values.where((element) => element.archived == false).toList();
    return result;
  }

  Future<void> saveNoteToHive(NoteModel note) async {
    NoteModel? result = box.get(note.id);

    if (result != null) {
      NoteModel updatedNote = result.copyWith(archived: !note.archived);

      await box.put(result.id, updatedNote);
    } else {}
  }
}
