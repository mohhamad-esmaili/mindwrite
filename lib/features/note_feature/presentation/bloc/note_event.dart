part of 'note_bloc.dart';

sealed class NoteEvent extends Equatable {
  const NoteEvent();

  @override
  List<Object?> get props => [];
}

class NoteInitialEvent extends NoteEvent {
  const NoteInitialEvent();
  @override
  List<Object?> get props => [];
}

class ChangeNoteEvent extends NoteEvent {
  final String? titleTextEditingController;
  final String? decriptionTextEditingController;

  const ChangeNoteEvent({
    this.titleTextEditingController,
    this.decriptionTextEditingController,
  });

  @override
  List<Object?> get props =>
      [titleTextEditingController, decriptionTextEditingController];
}

class ChangeNoteColorEvent extends NoteEvent {
  final Color selectedColor;
  const ChangeNoteColorEvent(this.selectedColor);
  @override
  List<Object?> get props => [selectedColor];
}

class ChangeNotePinEvent extends NoteEvent {
  final bool isPin;
  const ChangeNotePinEvent(this.isPin);
  @override
  List<Object?> get props => [isPin];
}

class SaveNoteEvent extends NoteEvent {
  final NoteModel noteModel;
  const SaveNoteEvent(this.noteModel);

  @override
  List<Object?> get props => [noteModel];
}
