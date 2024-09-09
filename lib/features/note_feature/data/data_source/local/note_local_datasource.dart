import 'package:hive_flutter/hive_flutter.dart';
import 'package:mindwrite/features/data/models/note_model.dart';
import 'package:mindwrite/features/domain/entities/note_model_entity.dart';
import 'package:mindwrite/locator.dart';

class NoteLocalDatasource {
  Box<NoteModel> box = locator();

  Future<NoteModel> saveNoteToHive(NoteModel note) async {
    await box.add(note);
    return note;
  }
}
