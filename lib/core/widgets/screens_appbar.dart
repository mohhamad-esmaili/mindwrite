import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindwrite/core/widgets/snackbar_widget.dart';
import 'package:mindwrite/features/shared_bloc/presentation/bloc/shared_bloc.dart';

class ScreensAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String appbarTitle;
  final SharedBloc sharedBloc;
  final bool isRestoreMode;
  // final Function(List<NoteModel> selectedItems) deleteNoteFunction;
  @override
  final Size preferredSize;
  const ScreensAppbar({
    super.key,
    required this.appbarTitle,
    required this.sharedBloc,
    required this.isRestoreMode,
    // required this.deleteNoteFunction
  }) : preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      switchInCurve: Curves.bounceIn,
      child: BlocBuilder<SharedBloc, SharedState>(
        bloc: sharedBloc,
        builder: (context, state) {
          if (state is SharedInitial) {
            if (state.isSelectionMode) {
              return AppBar(
                automaticallyImplyLeading: false,
                key: const ValueKey("on_delete"),
                leading: IconButton(
                  onPressed: () => sharedBloc.add(ExitSelectionMode()),
                  icon: const Icon(Icons.clear_rounded),
                ),
                title: Text(state.selectedItems.length.toString()),
                actions: [
                  !isRestoreMode
                      ? IconButton(
                          onPressed: () {
                            sharedBloc
                                .add(DeleteNoteEvent(state.selectedItems));
                            SnackbarService.showStatusSnackbar(
                                message: "Notes Deleted", context: context);
                          },
                          icon: const Icon(Icons.delete_outline_rounded),
                        )
                      : const SizedBox.shrink(),
                  isRestoreMode
                      ? IconButton(
                          onPressed: () {
                            sharedBloc
                                .add(RestoreNoteEvent(state.selectedItems));
                            SnackbarService.showStatusSnackbar(
                                message: "Notes restored", context: context);
                          },
                          icon: const Icon(Icons.restore),
                        )
                      : const SizedBox.shrink()
                ],
              );
            }
          }
          return AppBar(
            key: const ValueKey("normal"),
            title: Text(appbarTitle),
          );
        },
      ),
    );
  }
}
