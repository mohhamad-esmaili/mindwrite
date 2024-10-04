import 'package:mindwrite/features/shared_bloc/data/model/note_model.dart';

class NoteArguments {
  final NoteModel? selectedNote;
  final bool? editMode;

  NoteArguments({required this.selectedNote, this.editMode = false});
}
