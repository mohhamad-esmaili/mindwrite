import 'package:flutter/material.dart';

import 'package:mindwrite/features/shared_bloc/presentation/bloc/shared_bloc.dart';

class PopMenuWidget {
  Widget buildPopupMenu(BuildContext context, SharedBloc sharedBloc) {
    return PopupMenuButton<int>(
      onSelected: (item) => _onMenuItemSelected(context, item, sharedBloc),
      icon: Icon(Icons.more_vert, color: Theme.of(context).iconTheme.color),
      color: Theme.of(context).scaffoldBackgroundColor,
      itemBuilder: (context) => [
        // TODO: group archive isnt made
        PopupMenuItem<int>(
          value: 0,
          child: Text(
            'Archive',
            style: TextStyle(color: Colors.white),
          ),
        ),
        PopupMenuItem<int>(
          value: 1,
          child: Text(
            'Delete',
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
    }
  }
}
