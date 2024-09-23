import 'package:mindwrite/core/resources/data_state.dart';
import 'package:mindwrite/core/usecase/use_case.dart';
import 'package:mindwrite/features/label_feature/domain/repository/label_repository.dart';
import 'package:mindwrite/features/label_feature/data/model/label_model.dart';

class LoadLabelsUsecase
    implements UseCase<DataState<List<LabelModel>>, LabelModel> {
  final LabelRepository labelRepository;
  LoadLabelsUsecase(this.labelRepository);

  @override
  Future<DataState<List<LabelModel>>> call([void param]) async {
    try {
      final result = await labelRepository.loadLabelsFromBox();
      result.data!.sort((a, b) => b.createdDate!.compareTo(a.createdDate!));
      return DataSuccess(result.data);
    } catch (e) {
      return DataFailed('Failed to save label: ${e.toString()}');
    }
  }
}
