import 'package:hive_flutter/hive_flutter.dart';
import 'package:mindwrite/features/label_feature/data/model/label_model.dart';

import 'package:mindwrite/locator.dart';

class LabelLocalDatasource {
  Box<LabelModel> labelBox = locator(instanceName: 'label_box');

  Future<List<LabelModel>> loadLabelFromBox() async {
    return labelBox.values.toList();
  }

  Future<LabelModel?> saveLabelToBox(LabelModel label) async {
    List<LabelModel> loadedList = labelBox.values.toList();
    bool labelExists =
        loadedList.any((element) => element.labelName == label.labelName);

    if (labelExists) {
      return null;
    }

    await labelBox.put(label.id, label);
    return label;
  }

  Future<List<LabelModel>> editLabelToBox(LabelModel label) async {
    List<LabelModel> loadedList = labelBox.values.toList();
    print(label.labelName);
    bool labelNameExist =
        loadedList.any((element) => element.labelName == label.labelName);
    bool labelExists = loadedList.any((element) => element.id == label.id);
    if (labelNameExist) {
      return Future.error("Label already exists");
    } else if (labelExists) {
      await labelBox.put(label.id, label);
    }

    List<LabelModel> loadList = labelBox.values.toList();
    return loadList;
  }

  Future<LabelModel> deleteLabelFromBox(LabelModel label) async {
    await labelBox.delete(label.id);

    return label;
  }
}
