import 'package:hive_flutter/hive_flutter.dart';
import 'package:mindwrite/features/data/models/note_model.dart';
import 'package:mindwrite/locator.dart';

class HomeLocalDataBase {
  Box<NoteModel> box = locator();
  Future<List<NoteModel>> getListOfNotes() async {
    return box.values.toList();
  }
}
