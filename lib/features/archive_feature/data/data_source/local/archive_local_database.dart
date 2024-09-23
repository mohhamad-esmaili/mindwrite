import 'package:hive_flutter/hive_flutter.dart';
import 'package:mindwrite/features/shared_bloc/data/model/note_model.dart';
import 'package:mindwrite/locator.dart';

class ArchiveLocalDatabase {
  Box<NoteModel> box = locator(instanceName: "note_box");
  Future<List<NoteModel>> getAllArchivedNotes() async {
    List<NoteModel> result = box.values.toList();
    result = result
        .where(
            (element) => element.archived == true && element.isDeleted == false)
        .toList();
    return result;
  }
}
