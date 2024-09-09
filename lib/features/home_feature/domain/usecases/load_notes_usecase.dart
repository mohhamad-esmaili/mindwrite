import 'package:mindwrite/core/resources/data_state.dart';
import 'package:mindwrite/core/usecase/use_case.dart';

import 'package:mindwrite/features/data/models/note_model.dart';
import 'package:mindwrite/features/domain/entities/note_model_entity.dart';
import 'package:mindwrite/features/domain/repository/home_repository.dart';

class LoadAllNotes implements UseCase<DataState<List<NoteModel>>, NoteModel> {
  final HomeRepository noteRepository;
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
