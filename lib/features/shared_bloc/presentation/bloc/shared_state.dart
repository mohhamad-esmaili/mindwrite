part of 'shared_bloc.dart';

sealed class SharedState extends Equatable {
  final ThemeMode themeMode;
  final Locale appLocale;
  const SharedState({required this.themeMode, required this.appLocale});

  @override
  List<Object> get props => [themeMode, appLocale];
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
    Locale appLocale,
  ) : super(themeMode: themeMode, appLocale: appLocale);

  @override
  List<Object> get props =>
      [appLocale, isSelectionMode, selectedItems, listMode];
}

class SelectionModeActive extends SharedState {
  final List<NoteModel> selectedItems;
  const SelectionModeActive(this.selectedItems)
      : super(themeMode: ThemeMode.light, appLocale: const Locale('fa', ''));
  @override
  List<Object> get props => [selectedItems];
}

class SharedLoading extends SharedState {
  const SharedLoading(
      {super.themeMode = ThemeMode.light,
      super.appLocale = const Locale('fa', '')});
}

class SharedLoadFailed extends SharedState {
  const SharedLoadFailed(
      {super.themeMode = ThemeMode.light,
      super.appLocale = const Locale('fa', '')});
}
