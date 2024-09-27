import 'package:flutter/material.dart';
import 'package:mindwrite/core/usecase/copy_clipboard.dart';
import 'package:mindwrite/core/widgets/share_service.dart';

import 'package:mindwrite/features/shared_bloc/presentation/bloc/shared_bloc.dart';

class PopMenuWidget {
  Widget buildPopupMenu(BuildContext context, SharedBloc sharedBloc) {
    ThemeData themeData = Theme.of(context);
    return PopupMenuButton<int>(
      onSelected: (item) => _onMenuItemSelected(context, item, sharedBloc),
      icon: Icon(Icons.more_vert, color: themeData.iconTheme.color),
      color: themeData.scaffoldBackgroundColor,
      menuPadding: const EdgeInsets.all(10),
      itemBuilder: (context) => [
        PopupMenuItem<int>(
          value: 0,
          child: Text(
            'Archive',
            style: themeData.textTheme.labelMedium,
          ),
        ),
        PopupMenuItem<int>(
          value: 1,
          child: Text(
            'Delete',
            style: themeData.textTheme.labelMedium,
          ),
        ),
        if (sharedBloc.selectedItems.length == 1)
          PopupMenuItem<int>(
            value: 2,
            child: Text(
              'Make a copy',
              style: themeData.textTheme.labelMedium,
            ),
          ),
        if (sharedBloc.selectedItems.length == 1)
          PopupMenuItem<int>(
            value: 3,
            child: Text(
              'Send',
              style: themeData.textTheme.labelMedium,
            ),
          ),
      ],
    );
  }

  void _onMenuItemSelected(
      BuildContext context, int item, SharedBloc sharedBloc) {
    switch (item) {
      case 0:
        sharedBloc.add(
          ToggleArchiveEvent(sharedBloc.selectedItems),
        );
        sharedBloc.add(ExitSelectionMode());
        break;
      case 1:
        sharedBloc.add(
          DeleteNoteEvent(sharedBloc.selectedItems),
        );
        sharedBloc.add(ExitSelectionMode());
        break;
      case 2:
        CopyClipboardService.copyNoteToClipboard(
            sharedBloc.selectedItems.first.title!,
            sharedBloc.selectedItems.first.description,
            context);
        sharedBloc.add(ExitSelectionMode());
        break;
      case 3:
        ShareService.sendTo(sharedBloc.selectedItems.first, context);
        sharedBloc.add(ExitSelectionMode());
        break;
    }
  }
}
