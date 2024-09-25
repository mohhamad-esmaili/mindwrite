import 'package:mindwrite/core/usecase/use_case.dart';
import 'package:mindwrite/core/resources/data_state.dart';
import 'package:mindwrite/features/delete_feature/domain/repository/deleted_repository.dart';

import 'package:mindwrite/features/shared_bloc/data/model/note_model.dart';

class DeleteNotesForeverUsecase
    implements UseCase<DataState<List<NoteModel>>, List<NoteModel>> {
  final DeletedRepository deletedRepository;
  DeleteNotesForeverUsecase(this.deletedRepository);

  @override
  Future<DataState<List<NoteModel>>> call(List<NoteModel> selectedNotes) async {
    try {
      final result = await deletedRepository.deleteNotesForever(selectedNotes);

      return DataSuccess(result.data);
    } catch (e) {
      return DataFailed('Failed to save note: ${e.toString()}');
    }
  }
}
