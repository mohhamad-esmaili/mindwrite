import 'package:hive_flutter/hive_flutter.dart';
import 'package:mindwrite/features/label_feature/data/model/label_model.dart';
import 'package:mindwrite/features/shared_bloc/data/model/note_model.dart';

import 'package:mindwrite/locator.dart';

class LabelLocalDatasource {
  Box<LabelModel> labelBox = locator(instanceName: 'label_box');
  Box<NoteModel> noteBox = locator(instanceName: "note_box");

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

  Future<List<NoteModel>> getLabelNotes(LabelModel label) async {
    List<NoteModel> result = noteBox.values
        .toList()
        .where((element) => element.isDeleted == false)
        .toList();

    List<NoteModel> matchedNotes = [];

    for (NoteModel note in result) {
      if (note.labels != null && note.labels!.contains(label)) {
        matchedNotes.add(note);
      }
    }

    return matchedNotes;
  }

  Future<NoteModel> changeNoteLabel(NoteModel note) async {
    await noteBox.put(note.id, note);

    return note;
  }
}
