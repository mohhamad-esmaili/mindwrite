import 'package:mindwrite/core/resources/data_state.dart';
import 'package:mindwrite/core/usecase/use_case.dart';
import 'package:mindwrite/features/shared_bloc/data/model/note_model.dart';
import 'package:mindwrite/features/shared_bloc/domain/repository/shared_repository.dart';

class ToggleArchiveUsecase implements UseCase<DataState<NoteModel>, NoteModel> {
  final SharedRepository sharedRepository;
  ToggleArchiveUsecase(this.sharedRepository);
  @override
  Future<DataState<NoteModel>> call(NoteModel note) async {
    try {
      final result = await sharedRepository.toggleArchiveStatusToBox(note);

      return DataSuccess(result.data);
    } catch (e) {
      return DataFailed('Failed to save note: ${e.toString()}');
    }
  }
}
