part of 'shared_bloc.dart';

sealed class SharedEvent extends Equatable {
  const SharedEvent();

  @override
  List<Object> get props => [];
}

class LongPressItem extends SharedEvent {
  final NoteModel longNoteModel;
  const LongPressItem(this.longNoteModel);
  @override
  List<Object> get props => [longNoteModel];
}

class TapItem extends SharedEvent {
  final NoteModel tappedNoteModel;
  const TapItem(this.tappedNoteModel);
  @override
  List<Object> get props => [tappedNoteModel];
}

class ExitSelectionMode extends SharedEvent {}

class DeleteNoteEvent extends SharedEvent {
  List<NoteModel> selectedNotes;

  DeleteNoteEvent(this.selectedNotes);

  @override
  List<Object> get props => [selectedNotes];
}

class RestoreNoteEvent extends SharedEvent {
  List<NoteModel> selectedNotes;

  RestoreNoteEvent(this.selectedNotes);

  @override
  List<Object> get props => [selectedNotes];
}

class ToggleArchiveEvent extends SharedEvent {
  final NoteModel note;
  const ToggleArchiveEvent(this.note);
  @override
  List<Object> get props => [note];
}
