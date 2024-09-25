import 'package:flutter/material.dart';
import 'package:mindwrite/core/usecase/copy_clipboard.dart';
import 'package:mindwrite/core/widgets/share_service.dart';

import 'package:mindwrite/features/shared_bloc/presentation/bloc/shared_bloc.dart';

class PopMenuWidget {
  Widget buildPopupMenu(BuildContext context, SharedBloc sharedBloc) {
    return PopupMenuButton<int>(
      onSelected: (item) => _onMenuItemSelected(context, item, sharedBloc),
      icon: Icon(Icons.more_vert, color: Theme.of(context).iconTheme.color),
      color: Theme.of(context).scaffoldBackgroundColor,
      menuPadding: EdgeInsets.all(10),
      itemBuilder: (context) => [
        const PopupMenuItem<int>(
          value: 0,
          child: Text(
            'Archive',
            style: TextStyle(color: Colors.white),
          ),
        ),
        const PopupMenuItem<int>(
          value: 1,
          child: Text(
            'Delete',
            style: TextStyle(color: Colors.white),
          ),
        ),
        if (sharedBloc.selectedItems.length == 1)
          const PopupMenuItem<int>(
            value: 2,
            child: Text(
              'Make a copy',
              style: TextStyle(color: Colors.white),
            ),
          ),
        if (sharedBloc.selectedItems.length == 1)
          const PopupMenuItem<int>(
            value: 3,
            child: Text(
              'Send',
              style: TextStyle(color: Colors.white),
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
