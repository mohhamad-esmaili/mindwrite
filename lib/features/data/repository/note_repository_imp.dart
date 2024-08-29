import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mindwrite/core/resources/data_state.dart';
import 'package:mindwrite/features/data/models/note_model.dart';
import 'package:mindwrite/features/domain/repository/note_repository.dart';
import 'package:mindwrite/locator.dart';

class NoteRepositoryImp extends NoteRepository {
  final NoteModel createdNote;
  NoteRepositoryImp({required this.createdNote});

  Box<NoteModel> box = locator();

  @override
  Future<DataState<List<NoteModel>>> loadNotesFromBox() async {
    try {
      var allValues = box.values.toList();

      return DataSuccess(allValues);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

  // save one note when creating
  @override
  Future<DataState<NoteModel>> saveNoteToBox(NoteModel note) async {
    try {
      await box.add(note);
      return DataSuccess(note);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }
}
