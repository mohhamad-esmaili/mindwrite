import 'package:mindwrite/core/resources/data_state.dart';
import 'package:mindwrite/core/usecase/use_case.dart';
import 'package:mindwrite/features/label_feature/domain/repository/label_repository.dart';
import 'package:mindwrite/features/label_feature/data/model/label_model.dart';
import 'package:mindwrite/features/shared_bloc/data/model/note_model.dart';

class LoadLabelNotessUsecase
    implements UseCase<DataState<List<NoteModel>>, LabelModel> {
  final LabelRepository labelRepository;
  LoadLabelNotessUsecase(this.labelRepository);

  @override
  Future<DataState<List<NoteModel>>> call(LabelModel label) async {
    try {
      final result = await labelRepository.loadLabelNotesFromBox(label);
      result.data!.sort((a, b) => b.lastUpdate.compareTo(a.lastUpdate));
      return DataSuccess(result.data);
    } catch (e) {
      return DataFailed('Failed to save label: ${e.toString()}');
    }
  }
}
