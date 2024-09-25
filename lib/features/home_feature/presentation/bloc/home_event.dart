part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class LoadAllNotes extends HomeEvent {
  @override
  List<Object> get props => [];
}

class SearchNotesEvent extends HomeEvent {
  final String searchString;

  const SearchNotesEvent(this.searchString);
  @override
  List<Object> get props => [searchString];
}
