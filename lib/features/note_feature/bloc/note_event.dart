part of 'note_bloc.dart';

sealed class NoteEvent extends Equatable {
  const NoteEvent();

  @override
  List<Object?> get props => [];
}

class LoadNoteEvent extends NoteEvent {
  @override
  List<Object?> get props => [];
}

class ChangeNoteColorEvent extends NoteEvent {
  final Color selectedColor;
  const ChangeNoteColorEvent(this.selectedColor);

  @override
  List<Object?> get props => [selectedColor];
}
