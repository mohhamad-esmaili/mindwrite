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

class RefreshNoteDataEvent extends NoteEvent {
  final NoteModel? refreshedNote;
  const RefreshNoteDataEvent({this.refreshedNote});
  @override
  List<Object?> get props => [refreshedNote];
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

class ChangeDrawingLists extends NoteEvent {
  final Uint8List drewPaint;
  const ChangeDrawingLists(this.drewPaint);

  @override
  List<Object?> get props => [drewPaint];
}

class RemovePaintEvent extends NoteEvent {
  final Uint8List drewPaint;
  const RemovePaintEvent(this.drewPaint);

  @override
  List<Object?> get props => [drewPaint];
}

class ClearNoteDataEvent extends NoteEvent {
  const ClearNoteDataEvent();

  @override
  List<Object?> get props => [];
}
