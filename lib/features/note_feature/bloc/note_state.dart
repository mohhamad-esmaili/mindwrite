part of 'note_bloc.dart';

sealed class NoteState extends Equatable {
  const NoteState();

  @override
  List<Object> get props => [];
}

final class NoteInitial extends NoteState {
  final Color initialColor;
  const NoteInitial({this.initialColor = Colors.transparent});

  NoteInitial copyWith({Color? chosenColor}) {
    return NoteInitial(initialColor: chosenColor ?? initialColor);
  }

  @override
  List<Object> get props => [initialColor];
}
