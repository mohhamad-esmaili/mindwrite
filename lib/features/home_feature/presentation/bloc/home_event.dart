part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class GetAllNotesEvent extends HomeEvent {
  @override
  List<Object> get props => [];
}

class ToggleArchiveEvent extends HomeEvent {
  final NoteModel note;
  const ToggleArchiveEvent(this.note);
  @override
  List<Object> get props => [note];
}
