import 'package:equatable/equatable.dart';
import 'package:mindwrite/features/shared_bloc/data/model/note_model.dart';

abstract class DeleteEvent extends Equatable {
  const DeleteEvent();
  @override
  List<Object> get props => [];
}

class GetAllDeleted extends DeleteEvent {
  const GetAllDeleted();

  @override
  List<Object> get props => [];
}

class ToggleOffDeleteEvent extends DeleteEvent {
  final NoteModel note;
  const ToggleOffDeleteEvent(this.note);
  @override
  List<Object> get props => [note];
}

class DeleteNotesEvent extends DeleteEvent {
  final List<NoteModel> selectedNotes;
  const DeleteNotesEvent(this.selectedNotes);
  @override
  List<Object> get props => [selectedNotes];
}
