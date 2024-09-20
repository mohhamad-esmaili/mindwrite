import 'package:mindwrite/core/resources/data_state.dart';
import 'package:mindwrite/core/usecase/use_case.dart';
import 'package:mindwrite/features/shared_bloc/data/model/note_model.dart';
import 'package:mindwrite/features/shared_bloc/domain/repository/shared_repository.dart';

class ChangePaletterUsecase
    implements UseCase<DataState<List<NoteModel>>, List<NoteModel>> {
  final SharedRepository noteRepository;
  ChangePaletterUsecase(this.noteRepository);
  @override
  Future<DataState<List<NoteModel>>> call(List<NoteModel> notes) async {
    try {
      final result = await noteRepository.changePalette(notes);

      return DataSuccess(result.data);
    } catch (e) {
      return DataFailed('Failed to save note: ${e.toString()}');
    }
  }
}
