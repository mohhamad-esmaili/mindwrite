import 'package:mindwrite/core/resources/data_state.dart';
import 'package:mindwrite/features/shared_bloc/data/model/note_model.dart';

abstract class NoteRepository {
  Future<DataState<NoteModel>> saveNoteToBox(NoteModel note);
}
