part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {
  final List<NoteModel> notes;

  const HomeInitial(this.notes);

  @override
  List<Object> get props => [notes];
}

class HomeLoaded extends HomeState {
  final List<NoteModel> notes;
  final List<NoteModel> pinnedNotes;
  const HomeLoaded(this.notes, this.pinnedNotes);

  @override
  List<Object> get props => [notes, pinnedNotes];
}

class HomeLoading extends HomeState {
  final String loading;

  const HomeLoading(this.loading);

  @override
  List<Object> get props => [loading];
}

class HomeLoadFailed extends HomeState {
  final String error;

  const HomeLoadFailed(this.error);

  @override
  List<Object> get props => [error];
}
