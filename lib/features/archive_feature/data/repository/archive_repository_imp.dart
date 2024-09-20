import 'package:mindwrite/core/resources/data_state.dart';
import 'package:mindwrite/features/archive_feature/data/data_source/local/archive_local_database.dart';
import 'package:mindwrite/features/archive_feature/domain/repository/archive_repository.dart';
import 'package:mindwrite/features/shared_bloc/data/model/note_model.dart';

class ArchiveRepositoryImp extends ArchiveRepository {
  ArchiveLocalDatabase archiveLocalDatabase = ArchiveLocalDatabase();
  @override
  Future<DataState<List<NoteModel>>> loadArchivedNotesFromBox() async {
    try {
      List<NoteModel> allValues =
          await archiveLocalDatabase.getAllArchivedNotes();
      return DataSuccess(allValues);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }
}
