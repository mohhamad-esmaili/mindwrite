import 'package:mindwrite/core/resources/data_state.dart';
import 'package:mindwrite/core/usecase/use_case.dart';
import 'package:mindwrite/features/shared_bloc/data/model/note_model.dart';

import 'package:mindwrite/features/note_feature/domain/repository/note_repository.dart';

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
