import 'package:mindwrite/core/resources/data_state.dart';

import 'package:mindwrite/features/delete_feature/data/data_source/local/deleted_local_database.dart';
import 'package:mindwrite/features/delete_feature/domain/repository/deleted_repository.dart';
import 'package:mindwrite/features/shared_bloc/data/model/note_model.dart';

class DeletedRepositoryImp extends DeletedRepository {
  DeletedLocalDatabase deletedLocalDatabase = DeletedLocalDatabase();

  @override
  Future<DataState<List<NoteModel>>> loadDeletedNotesFromBox() async {
    try {
      List<NoteModel> allValues =
          await deletedLocalDatabase.getAllDeletedNotes();
      return DataSuccess(allValues);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }
}
