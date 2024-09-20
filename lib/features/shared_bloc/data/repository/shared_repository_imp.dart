import 'package:mindwrite/core/resources/data_state.dart';
import 'package:mindwrite/features/shared_bloc/data/model/note_model.dart';
import 'package:mindwrite/features/shared_bloc/data/data_source/shared_local_database.dart';

import 'package:mindwrite/features/shared_bloc/domain/repository/shared_repository.dart';

class SharedRepositoryImp extends SharedRepository {
  SharedRepositoryImp();
  SharedLocalDatabase sharedLocalDatabase = SharedLocalDatabase();

  @override
  Future<DataState<List<NoteModel>>> restoreNoteToBox(
      List<NoteModel> notes) async {
    try {
      await sharedLocalDatabase.restoreNoteFromBox(notes);

      return DataSuccess(notes);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<List<NoteModel>>> deleteNote(List<NoteModel> notes) async {
    try {
      await sharedLocalDatabase.deleteNoteFromBox(notes);
      return DataSuccess(notes);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<NoteModel>> toggleArchiveStatusToBox(NoteModel note) async {
    try {
      await sharedLocalDatabase.toggleNoteArchiveToBox(note);
      return DataSuccess(note);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<List<NoteModel>>> pinToggle(List<NoteModel> notes) async {
    try {
      await sharedLocalDatabase.pinToggleToBox(notes);
      return DataSuccess(notes);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }
}