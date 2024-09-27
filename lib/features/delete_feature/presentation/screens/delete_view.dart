import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart'; // import flutter_animate

import 'package:mindwrite/core/widgets/app_drawer.dart';
import 'package:mindwrite/core/widgets/masonary_builder.dart';
import 'package:mindwrite/core/widgets/snackbar_widget.dart';
import 'package:mindwrite/features/delete_feature/presentation/bloc/delete_bloc.dart';
import 'package:mindwrite/features/delete_feature/presentation/bloc/delete_event.dart';
import 'package:mindwrite/features/delete_feature/presentation/bloc/delete_state.dart';

import 'package:mindwrite/features/shared_bloc/presentation/bloc/shared_bloc.dart';

class DeleteView extends StatefulWidget {
  const DeleteView({super.key});

  @override
  State<DeleteView> createState() => _DeleteViewState();
}

class _DeleteViewState extends State<DeleteView> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<DeleteBloc>().add(const GetAllDeleted());
  }

  @override
  Widget build(BuildContext context) {
    SharedBloc sharedBloc = BlocProvider.of<SharedBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Deleted"),
        actions: [
          BlocBuilder<SharedBloc, SharedState>(
            bloc: sharedBloc,
            builder: (context, state) {
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(opacity: animation, child: child);
                },
                child: sharedBloc.isSelectionMode
                    ? Row(
                        key: const ValueKey('restoreMode'),
                        children: [
                          IconButton(
                            onPressed: () {
                              sharedBloc.add(
                                  RestoreNoteEvent(sharedBloc.selectedItems));
                              SnackbarService.showStatusSnackbar(
                                  message: "Notes restored", context: context);
                            },
                            icon: const Icon(Icons.restore),
                          ),
                          popupMenu(
                            'Delete forever',
                            () => context.read<DeleteBloc>().add(
                                  DeleteNotesEvent(sharedBloc.selectedItems),
                                ),
                          )
                        ],
                      )
                    : Row(
                        key: const ValueKey('defaultMode'),
                        children: [
                          popupMenu('Empty bin', () {
                            if (context
                                .read<DeleteBloc>()
                                .allDeletedNotes
                                .isNotEmpty) {
                              context.read<DeleteBloc>().add(DeleteNotesEvent(
                                  context.read<DeleteBloc>().allDeletedNotes));
                            } else {
                              SnackbarService.showStatusSnackbar(
                                  message: "Already empty", context: context);
                            }
                          }),
                        ],
                      ),
              );
            },
          ).animate().fade(duration: 300.ms),
        ],
      ),
      drawer: const AppDrawer(),
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Scrollbar(
                thickness: 2,
                radius: const Radius.circular(20),
                interactive: true,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      BlocBuilder<DeleteBloc, DeleteState>(
                        builder: (context, state) {
                          if (state is DeleteLoaded) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MasonaryBuilder(
                                  sharedBloc: sharedBloc,
                                  noteModelList: state.deletedNotes,
                                  defaultArchiveNote: true,
                                  deleteScreen: true,
                                ),
                              ],
                            );
                          } else if (state is DeleteLoadFailed) {
                            return Center(
                              child: Text(
                                'Failed to load notes: ${state.error}',
                                style: const TextStyle(color: Colors.red),
                              ),
                            );
                          } else {
                            return const SizedBox
                                .shrink(); // Empty state fallback
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Adjusted popupMenu function
  Widget popupMenu(String buttonName, VoidCallback onPress) {
    ThemeData themeData = Theme.of(context);
    return PopupMenuButton<int>(
      onSelected: (item) => onPress(),
      icon: Icon(Icons.more_vert, color: themeData.iconTheme.color),
      color: themeData.scaffoldBackgroundColor,
      itemBuilder: (context) => [
        PopupMenuItem<int>(
          value: 0,
          child: Text(
            buttonName,
            style: themeData.textTheme.labelMedium,
          ),
        ),
      ],
    );
  }
}
