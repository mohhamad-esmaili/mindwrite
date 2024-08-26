import 'package:mindwrite/core/resources/data_state.dart';
import 'package:mindwrite/features/data/models/note_model.dart';

abstract class NoteRepository {
  Future<DataState<NoteModel>> saveNoteToBox();
}