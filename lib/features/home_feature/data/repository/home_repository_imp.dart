import 'package:mindwrite/core/resources/data_state.dart';
import 'package:mindwrite/features/home_feature/data/data_source/local/home_local_database.dart';
import 'package:mindwrite/features/shared_bloc/data/model/note_model.dart';
import 'package:mindwrite/features/home_feature/domain/repository/home_repository.dart';

class HomeRepositoryImp extends HomeRepository {
  final NoteModel createdNote;

  HomeRepositoryImp({required this.createdNote});
  HomeLocalDataBase homeLocalDataBase = HomeLocalDataBase();
  @override
  Future<DataState<List<NoteModel>>> loadNotesFromBox() async {
    try {
      List<NoteModel> allValues = await homeLocalDataBase.getListOfNotes();
      return DataSuccess(allValues);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<NoteModel>> saveNotesToBox(NoteModel note) async {
    try {
      await homeLocalDataBase.saveNoteToBox(note);
      return DataSuccess(note);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }
}
