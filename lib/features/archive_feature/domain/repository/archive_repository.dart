import 'package:mindwrite/core/resources/data_state.dart';
import 'package:mindwrite/features/home_feature/data/model/note_model.dart';

abstract class ArchiveRepository {
  Future<DataState<List<NoteModel>>> loadArchivedNotesFromBox();
}
