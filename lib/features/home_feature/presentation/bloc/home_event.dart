part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class GetNotesEvent extends HomeEvent {
  @override
  List<Object> get props => [];
}

class GetPinnedNotesEvent extends HomeEvent {
  @override
  List<Object> get props => [];
}
