import 'package:mindwrite/core/resources/data_state.dart';
import 'package:mindwrite/core/usecase/use_case.dart';
import 'package:mindwrite/features/archive_feature/domain/repository/archive_repository.dart';

import 'package:mindwrite/features/shared_bloc/data/model/note_model.dart';

class GetArchivedUsecase
    implements UseCase<DataState<List<NoteModel>>, NoteModel> {
  final ArchiveRepository archiveRepository;
  GetArchivedUsecase(this.archiveRepository);

  @override
  Future<DataState<List<NoteModel>>> call([void param]) async {
    try {
      final result = await archiveRepository.loadArchivedNotesFromBox();

      return DataSuccess(result.data);
    } catch (e) {
      return DataFailed('Failed to save note: ${e.toString()}');
    }
  }
}
