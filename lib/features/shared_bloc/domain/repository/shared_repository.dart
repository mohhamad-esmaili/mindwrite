import 'package:mindwrite/core/resources/data_state.dart';
import 'package:mindwrite/features/shared_bloc/data/model/note_model.dart';

abstract class SharedRepository {
  Future<DataState<NoteModel>> toggleArchiveStatusToBox(NoteModel note);
  Future<DataState<List<NoteModel>>> restoreNoteToBox(List<NoteModel> notes);
  Future<DataState<List<NoteModel>>> deleteNote(List<NoteModel> notes);
}
