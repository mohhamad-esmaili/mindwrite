import 'package:mindwrite/core/resources/data_state.dart';
import 'package:mindwrite/features/home_feature/data/models/note_model.dart';

abstract class HomeRepository {
  Future<DataState<List<NoteModel>>> loadNotesFromBox();
}
