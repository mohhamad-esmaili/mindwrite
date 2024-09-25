import 'package:hive_flutter/hive_flutter.dart';
import 'package:mindwrite/features/shared_bloc/data/model/note_model.dart';
import 'package:mindwrite/locator.dart';

class DeletedLocalDatabase {
  Box<NoteModel> box = locator(instanceName: "note_box");
  Future<List<NoteModel>> getAllDeletedNotes() async {
    List<NoteModel> result = box.values.toList();
    result = result.where((element) => element.isDeleted == true).toList();

    return result;
  }

  Future<List<NoteModel>> deleteNoteForever(
      List<NoteModel> selectedNotes) async {
    for (var element in selectedNotes) {
      box.delete(element.id);
    }
    List<NoteModel> result = box.values.toList();
    result = result.where((element) => element.isDeleted == true).toList();
    return result;
  }
}
