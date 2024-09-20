part of 'shared_bloc.dart';

sealed class SharedState extends Equatable {
  const SharedState();

  @override
  List<Object> get props => [];
}

final class SharedInitial extends SharedState {
  final List<NoteModel> selectedItems;
  final bool isSelectionMode;
  const SharedInitial(this.selectedItems, this.isSelectionMode);

  @override
  List<Object> get props => [isSelectionMode, selectedItems];
}

class SelectionModeActive extends SharedState {
  final List<NoteModel> selectedItems;
  const SelectionModeActive(this.selectedItems);
}

class SharedLoading extends SharedState {}

class SharedLoadFailed extends SharedState {}