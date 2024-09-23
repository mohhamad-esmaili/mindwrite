import 'package:mindwrite/core/resources/data_state.dart';
import 'package:mindwrite/features/label_feature/data/model/label_model.dart';

abstract class LabelRepository {
  Future<DataState<List<LabelModel>>> loadLabelsFromBox();
  Future<DataState<LabelModel>> saveLabelToBox(LabelModel label);
  Future<DataState<List<LabelModel>>> editLabelToBox(LabelModel label);
  Future<DataState<LabelModel>> deleteLabel(LabelModel label);
}
