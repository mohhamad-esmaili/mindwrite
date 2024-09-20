import 'package:mindwrite/core/usecase/use_case.dart';
import 'package:mindwrite/core/resources/data_state.dart';
import 'package:mindwrite/features/delete_feature/domain/repository/deleted_repository.dart';

import 'package:mindwrite/features/shared_bloc/data/model/note_model.dart';

class GetDeletedUsecase
    implements UseCase<DataState<List<NoteModel>>, NoteModel> {
  final DeletedRepository adeletedRepository;
  GetDeletedUsecase(this.adeletedRepository);

  @override
  Future<DataState<List<NoteModel>>> call([void param]) async {
    try {
      final result = await adeletedRepository.loadDeletedNotesFromBox();

      return DataSuccess(result.data);
    } catch (e) {
      return DataFailed('Failed to save note: ${e.toString()}');
    }
  }
}
