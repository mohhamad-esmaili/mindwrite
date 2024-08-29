import 'package:mindwrite/core/resources/data_state.dart';
import 'package:mindwrite/core/usecase/use_case.dart';

import 'package:mindwrite/features/data/models/note_model.dart';
import 'package:mindwrite/features/domain/repository/note_repository.dart';

class SaveNoteToBoxUsecase implements UseCase<DataState<NoteModel>, NoteModel> {
  final NoteRepository noteRepository;
  SaveNoteToBoxUsecase(this.noteRepository);

  @override
  Future<DataState<NoteModel>> call(NoteModel note) async {
    try {
      final result = await noteRepository.saveNoteToBox(note);

      return result;
    } catch (e) {
      return DataFailed('Failed to save note: ${e.toString()}');
    }
  }
}

class LoadAllNotes implements UseCase<DataState<List<NoteModel>>, NoteModel> {
  final NoteRepository noteRepository;
  LoadAllNotes(this.noteRepository);

  @override
  Future<DataState<List<NoteModel>>> call([void param]) async {
    try {
      final result = await noteRepository.loadNotesFromBox();

      return DataSuccess(result.data);
    } catch (e) {
      return DataFailed('Failed to save note: ${e.toString()}');
    }
  }
}
