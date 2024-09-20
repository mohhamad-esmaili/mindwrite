import 'package:mindwrite/core/resources/data_state.dart';
import 'package:mindwrite/core/usecase/use_case.dart';

import 'package:mindwrite/features/shared_bloc/data/model/note_model.dart';
import 'package:mindwrite/features/home_feature/domain/repository/home_repository.dart';

class LoadNotesUsecase
    implements UseCase<DataState<List<NoteModel>>, NoteModel> {
  final HomeRepository noteRepository;
  LoadNotesUsecase(this.noteRepository);

  @override
  Future<DataState<List<NoteModel>>> call([void param]) async {
    try {
      final result = await noteRepository.loadNotesFromBox();

      result.data!.sort((a, b) => b.lastUpdate.compareTo(a.lastUpdate));
      return DataSuccess(result.data);
    } catch (e) {
      return DataFailed('Failed to save note: ${e.toString()}');
    }
  }
}
