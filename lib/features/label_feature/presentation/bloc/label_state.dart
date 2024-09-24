part of 'label_bloc.dart';

sealed class LabelState extends Equatable {
  const LabelState();

  @override
  List<Object> get props => [];
}

final class LabelInitial extends LabelState {
  final List<LabelModel> labelList;
  const LabelInitial(this.labelList);
  @override
  List<Object> get props => [labelList];
}

final class LabelNoteInitial extends LabelState {
  final List<NoteModel> noteList;
  final List<NoteModel> pinnednoteList;
  const LabelNoteInitial(this.noteList, this.pinnednoteList);
  @override
  List<Object> get props => [noteList, pinnednoteList];
}

final class LabelLoading extends LabelState {}

final class LabelFailed extends LabelState {
  final String error;
  const LabelFailed(this.error);
  @override
  List<Object> get props => [error];
}
