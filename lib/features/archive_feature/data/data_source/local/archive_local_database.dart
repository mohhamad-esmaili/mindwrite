import 'package:hive_flutter/hive_flutter.dart';
import 'package:mindwrite/features/home_feature/data/model/note_model.dart';
import 'package:mindwrite/locator.dart';

class ArchiveLocalDatabase {
  Box<NoteModel> box = locator();
  Future<List<NoteModel>> getAllArchivedNotes() async {
    List<NoteModel> result = box.values.toList();
    result = result.where((element) => element.archived == true).toList();
    return result;
  }
}
