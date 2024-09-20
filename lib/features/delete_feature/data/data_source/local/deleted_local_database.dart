import 'package:hive_flutter/hive_flutter.dart';
import 'package:mindwrite/features/shared_bloc/data/model/note_model.dart';
import 'package:mindwrite/locator.dart';

class DeletedLocalDatabase {
  Box<NoteModel> box = locator();
  Future<List<NoteModel>> getAllDeletedNotes() async {
    List<NoteModel> result = box.values.toList();
    result = result.where((element) => element.isDeleted == true).toList();

    return result;
  }
}
