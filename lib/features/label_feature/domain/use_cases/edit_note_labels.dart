import 'package:mindwrite/core/resources/data_state.dart';
import 'package:mindwrite/core/usecase/use_case.dart';
import 'package:mindwrite/features/label_feature/domain/repository/label_repository.dart';

import 'package:mindwrite/features/shared_bloc/data/model/note_model.dart';

class EditNoteLabelsUsecase
    implements UseCase<DataState<NoteModel>, NoteModel> {
  final LabelRepository labelRepository;
  EditNoteLabelsUsecase(this.labelRepository);

  @override
  Future<DataState<NoteModel>> call(NoteModel note) async {
    try {
      final result = await labelRepository.editNoteLabels(note);

      return DataSuccess(result.data);
    } catch (e) {
      return DataFailed('Failed to save label: ${e.toString()}');
    }
  }
}
