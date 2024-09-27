part of 'shared_bloc.dart';

sealed class SharedState extends Equatable {
  final ThemeMode themeMode;
  const SharedState({required this.themeMode});

  @override
  List<Object> get props => [themeMode];
}

final class SharedInitial extends SharedState {
  final List<NoteModel> selectedItems;
  final bool isSelectionMode;
  final ListModeEnum listMode;
  const SharedInitial(
    this.selectedItems,
    this.isSelectionMode,
    this.listMode,
    ThemeMode themeMode,
  ) : super(themeMode: themeMode);

  @override
  List<Object> get props => [isSelectionMode, selectedItems, listMode];
}

class SelectionModeActive extends SharedState {
  final List<NoteModel> selectedItems;
  const SelectionModeActive(this.selectedItems)
      : super(themeMode: ThemeMode.dark);
  @override
  List<Object> get props => [selectedItems];
}

class SharedLoading extends SharedState {
  const SharedLoading({super.themeMode = ThemeMode.light});
}

class SharedLoadFailed extends SharedState {
  const SharedLoadFailed({super.themeMode = ThemeMode.light});
}
