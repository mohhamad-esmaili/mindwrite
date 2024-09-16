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
  final DateTime? lastUpdate;
  final Color selectedColor;
  final String? selectedBackground;
  final int? descriptionLines;

  const ChangeNoteEvent({
    this.lastUpdate,
    this.titleTextEditingController,
    this.decriptionTextEditingController,
    this.descriptionLines,
    this.selectedColor = Colors.transparent,
    this.selectedBackground,
  });

  @override
  List<Object?> get props => [
        lastUpdate,
        titleTextEditingController,
        decriptionTextEditingController,
        descriptionLines,
        selectedColor,
        selectedBackground
      ];
}

class ChangeNoteColorsPalette extends NoteEvent {
  final Color selectedColor;
  final String? selectedBackground;

  const ChangeNoteColorsPalette({
    this.selectedColor = Colors.transparent,
    this.selectedBackground,
  });

  @override
  List<Object?> get props => [selectedColor, selectedBackground];
}

class ChangeNoteColorEvent extends NoteEvent {
  final Color selectedColor;

  final String? selectedBackGround;
  const ChangeNoteColorEvent(this.selectedColor, this.selectedBackGround);
  @override
  List<Object?> get props => [selectedColor, selectedBackGround];
}

class ChangeNotePinEvent extends NoteEvent {
  final bool isPin;
  const ChangeNotePinEvent(this.isPin);
  @override
  List<Object?> get props => [isPin];
}

class NoteArchiveEvent extends NoteEvent {
  final bool isArchived;
  const NoteArchiveEvent(this.isArchived);
  @override
  List<Object?> get props => [isArchived];
}

class SaveNoteEvent extends NoteEvent {
  final NoteModel noteModel;
  const SaveNoteEvent(this.noteModel);

  @override
  List<Object?> get props => [noteModel];
}
