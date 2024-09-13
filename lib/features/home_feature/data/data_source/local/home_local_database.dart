import 'package:hive_flutter/hive_flutter.dart';
import 'package:mindwrite/features/home_feature/data/model/note_model.dart';
import 'package:mindwrite/locator.dart';

class HomeLocalDataBase {
  Box<NoteModel> box = locator();
  Future<List<NoteModel>> getListOfNotes() async {
    List<NoteModel> result =
        box.values.where((element) => element.archived == false).toList();
    for (var element in result) {
      print(element.archived);
    }
    return result;
  }

  Future<void> saveNoteToHive(NoteModel note) async {
    NoteModel? result = box.get(note.id);
    print("in the save home: ${note.archived}");
    if (result != null) {
      NoteModel updatedNote = result.copyWith(archived: !note.archived);
      print(updatedNote.archived);
      await box.put(result.id, updatedNote);
    } else {}
  }
}
