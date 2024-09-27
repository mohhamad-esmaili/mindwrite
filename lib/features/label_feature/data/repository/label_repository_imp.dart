import 'package:mindwrite/core/resources/data_state.dart';
import 'package:mindwrite/features/label_feature/data/data_source/local/label_local_datasource.dart';
import 'package:mindwrite/features/label_feature/domain/repository/label_repository.dart';
import 'package:mindwrite/features/label_feature/data/model/label_model.dart';
import 'package:mindwrite/features/shared_bloc/data/model/note_model.dart';

class LabelRepositoryImp extends LabelRepository {
  LabelLocalDatasource labelLocalDatasource = LabelLocalDatasource();
  @override
  Future<DataState<List<LabelModel>>> loadLabelsFromBox() async {
    try {
      List<LabelModel> label = await labelLocalDatasource.loadLabelFromBox();

      return DataSuccess(label);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<LabelModel>> saveLabelToBox(LabelModel label) async {
    try {
      final result = await labelLocalDatasource.saveLabelToBox(label);
      if (result == null) {
        return const DataFailed("label exist");
      }
      return DataSuccess(result);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<List<LabelModel>>> editLabelToBox(LabelModel label) async {
    try {
      final result = await labelLocalDatasource.editLabelToBox(label);

      return DataSuccess(result);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<LabelModel>> deleteLabel(LabelModel label) async {
    try {
      final result = await labelLocalDatasource.deleteLabelFromBox(label);

      return DataSuccess(result);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<List<NoteModel>>> loadLabelNotesFromBox(
      LabelModel label) async {
    try {
      List<NoteModel> notes = await labelLocalDatasource.getLabelNotes(label);

      return DataSuccess(notes);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<NoteModel>> editNoteLabels(NoteModel note) async {
    try {
      NoteModel notes = await labelLocalDatasource.changeNoteLabel(note);

      return DataSuccess(notes);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }
}
