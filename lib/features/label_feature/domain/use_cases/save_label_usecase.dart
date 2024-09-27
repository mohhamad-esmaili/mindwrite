import 'package:mindwrite/core/resources/data_state.dart';
import 'package:mindwrite/core/usecase/use_case.dart';
import 'package:mindwrite/features/label_feature/domain/repository/label_repository.dart';
import 'package:mindwrite/features/label_feature/data/model/label_model.dart';

class SaveLabelUsecase implements UseCase<DataState<void>, LabelModel> {
  final LabelRepository labelRepository;
  SaveLabelUsecase(this.labelRepository);

  @override
  Future<DataState<LabelModel>> call(LabelModel label) async {
    try {
      final result = await labelRepository.saveLabelToBox(label);
      if (result is DataFailed) {
        return const DataFailed('label exist');
      }
      return DataSuccess(result.data);
    } catch (e) {
      return DataFailed('Failed to save label: ${e.toString()}');
    }
  }
}
