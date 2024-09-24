import 'package:hive_flutter/hive_flutter.dart';

import 'package:mindwrite/features/shared_bloc/data/model/note_model.dart';
import 'package:mindwrite/locator.dart';

class NoteLocalDatasource {
  Box<NoteModel> noteBox = locator(instanceName: "note_box");

  Future<NoteModel> saveNoteToHive(NoteModel note) async {
    await noteBox.put(note.id, note);
    return note;
  }
}
