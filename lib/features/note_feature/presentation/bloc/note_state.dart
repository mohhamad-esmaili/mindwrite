part of 'note_bloc.dart';

sealed class NoteState extends Equatable {
  const NoteState();

  @override
  List<Object> get props => [];
}

class NoteInitial extends NoteState {
  final NoteModel note;

  final int? descriptionLines;

  const NoteInitial(this.note, {this.descriptionLines = 1});

  @override
  List<Object> get props => [note];
}

class NoteSaving extends NoteState {}

class NoteChanged extends NoteState {
  final NoteModel note;

  const NoteChanged(this.note);

  @override
  List<Object> get props => [note];
}

class NoteSaveFailed extends NoteState {
  final String error;

  const NoteSaveFailed(this.error);

  @override
  List<Object> get props => [error];
}
