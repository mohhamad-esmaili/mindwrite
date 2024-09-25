import 'package:mindwrite/core/resources/data_state.dart';
import 'package:mindwrite/features/shared_bloc/data/model/note_model.dart';

abstract class DeletedRepository {
  Future<DataState<List<NoteModel>>> loadDeletedNotesFromBox();
  Future<DataState<List<NoteModel>>> deleteNotesForever(
      List<NoteModel> selectedNotes);
}
