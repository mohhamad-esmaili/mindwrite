part of 'label_bloc.dart';

sealed class LabelEvent extends Equatable {
  const LabelEvent();

  @override
  List<Object> get props => [];
}

class LoadLabelsEvent extends LabelEvent {}

class SaveLabelEvent extends LabelEvent {
  final LabelModel createdLabel;
  const SaveLabelEvent(this.createdLabel);

  @override
  List<Object> get props => [createdLabel];
}

class EditLabelEvent extends LabelEvent {
  final LabelModel selectedLabel;
  const EditLabelEvent(this.selectedLabel);

  @override
  List<Object> get props => [selectedLabel];
}

class DeleteLabelEvent extends LabelEvent {
  final LabelModel selectedLabel;
  const DeleteLabelEvent(this.selectedLabel);

  @override
  List<Object> get props => [selectedLabel];
}

class LoadLabelNotesEvent extends LabelEvent {
  final LabelModel selectedLabel;
  const LoadLabelNotesEvent({required this.selectedLabel});
  @override
  List<Object> get props => [selectedLabel];
}

class EditNoteLabelsEvent extends LabelEvent {
  final LabelModel selectedLabel;
  final NoteModel selectedNote;
  const EditNoteLabelsEvent(
      {required this.selectedLabel, required this.selectedNote});
  @override
  List<Object> get props => [selectedLabel, selectedNote];
}
