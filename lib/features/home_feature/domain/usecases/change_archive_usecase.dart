import 'package:mindwrite/core/resources/data_state.dart';
import 'package:mindwrite/core/usecase/use_case.dart';
import 'package:mindwrite/features/home_feature/data/model/note_model.dart';
import 'package:mindwrite/features/home_feature/domain/repository/home_repository.dart';

class ChangeArchiveUsecase implements UseCase<DataState<NoteModel>, NoteModel> {
  final HomeRepository noteRepository;
  ChangeArchiveUsecase(this.noteRepository);
  @override
  Future<DataState<NoteModel>> call(NoteModel note) async {
    try {
      final result = await noteRepository.saveNotesToBox(note);

      return DataSuccess(result.data);
    } catch (e) {
      return DataFailed('Failed to save note: ${e.toString()}');
    }
  }
}
