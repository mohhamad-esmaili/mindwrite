import 'package:mindwrite/core/resources/data_state.dart';
import 'package:mindwrite/features/shared_bloc/data/model/note_model.dart';
import 'package:mindwrite/features/note_feature/data/data_source/local/note_local_datasource.dart';
import 'package:mindwrite/features/note_feature/domain/repository/note_repository.dart';

class NoteRepositoryImp extends NoteRepository {
  NoteLocalDatasource noteLocalDatasource = NoteLocalDatasource();
  // save one note when creating
  @override
  Future<DataState<NoteModel>> saveNoteToBox(NoteModel note) async {
    try {
      note = await noteLocalDatasource.saveNoteToHive(note);

      return DataSuccess(note);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }
}
