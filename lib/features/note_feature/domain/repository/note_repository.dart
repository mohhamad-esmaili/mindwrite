import 'package:mindwrite/core/resources/data_state.dart';
import 'package:mindwrite/features/data/models/note_model.dart';
import 'package:mindwrite/features/domain/entities/note_model_entity.dart';

abstract class NoteRepository {
  Future<DataState<NoteModel>> saveNoteToBox(NoteModel note);
}
