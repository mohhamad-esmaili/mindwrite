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
  final List<NoteModel> selectedNotes;

  const DeleteNoteEvent(this.selectedNotes);

  @override
  List<Object> get props => [selectedNotes];
}

class RestoreNoteEvent extends SharedEvent {
  final List<NoteModel> selectedNotes;

  const RestoreNoteEvent(this.selectedNotes);

  @override
  List<Object> get props => [selectedNotes];
}

class ToggleArchiveEvent extends SharedEvent {
  final List<NoteModel> notes;
  const ToggleArchiveEvent(this.notes);
  @override
  List<Object> get props => [notes];
}

class PinNotesEvent extends SharedEvent {
  final List<NoteModel> selectedNotes;

  const PinNotesEvent(this.selectedNotes);

  @override
  List<Object> get props => [selectedNotes];
}

class ChangePaletteNoteEvent extends SharedEvent {
  final Color selectedLightColor;
  final Color selectedDarkColor;
  const ChangePaletteNoteEvent(this.selectedLightColor, this.selectedDarkColor);

  @override
  List<Object> get props => [selectedLightColor, selectedDarkColor];
}

class ChangeCrossAxisCountEvent extends SharedEvent {
  const ChangeCrossAxisCountEvent();

  @override
  List<Object> get props => [];
}

class LoadThemeMode extends SharedEvent {}

class ToggleTheme extends SharedEvent {}
