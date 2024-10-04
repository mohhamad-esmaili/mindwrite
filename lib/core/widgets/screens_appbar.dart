import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindwrite/core/enums/listmode_enum.dart';
import 'package:mindwrite/core/widgets/pop_menu_widget.dart';
import 'package:mindwrite/core/widgets/snackbar_widget.dart';
import 'package:mindwrite/features/shared_bloc/presentation/bloc/shared_bloc.dart';

class ScreensAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String appbarTitle;
  final SharedBloc sharedBloc;
  final Function? onDelete;
  @override
  final Size preferredSize;
  const ScreensAppbar({
    super.key,
    required this.appbarTitle,
    required this.sharedBloc,
    this.onDelete,
  }) : preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
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
                  IconButton(
                    onPressed: () => sharedBloc.add(
                      PinNotesEvent(sharedBloc.selectedItems),
                    ),
                    icon: Icon(
                      Icons.push_pin_rounded,
                      color: themeData.iconTheme.color,
                    ),
                  ),
                  IconButton(
                    onPressed: () =>
                        SnackbarService.showPaletteSelector(context: context),
                    icon: Icon(
                      Icons.palette_outlined,
                      color: themeData.iconTheme.color,
                    ),
                  ),
                  PopMenuWidget().buildPopupMenu(context, sharedBloc),
                ],
              );
            }
          }
          return AppBar(
            key: const ValueKey("normal"),
            title: Text(appbarTitle),
            actions: [
              IconButton(
                onPressed: () => sharedBloc.add(
                  const ChangeCrossAxisCountEvent(),
                ),
                icon: Icon(
                  sharedBloc.listMode == ListModeEnum.single
                      ? Icons.auto_awesome_mosaic_rounded
                      : Icons.splitscreen_rounded,
                  color: themeData.iconTheme.color,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
