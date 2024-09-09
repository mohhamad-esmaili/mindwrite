part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {
  final List<NoteModelEntity> notes;

  const HomeInitial(this.notes);

  @override
  List<Object> get props => [notes];
}

class HomeLoaded extends HomeState {
  final List<NoteModelEntity> notes;
  final List<NoteModelEntity> pinnedNotes;
  const HomeLoaded(this.notes, this.pinnedNotes);

  @override
  List<Object> get props => [notes];
}

class HomeLoadFailed extends HomeState {
  final String error;

  const HomeLoadFailed(this.error);

  @override
  List<Object> get props => [error];
}
