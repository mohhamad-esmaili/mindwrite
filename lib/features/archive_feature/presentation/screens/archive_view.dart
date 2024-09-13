import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:mindwrite/core/widgets/app_drawer.dart';
import 'package:mindwrite/core/widgets/snackbar_widget.dart';
import 'package:mindwrite/features/archive_feature/presentation/bloc/archive_bloc.dart';
import 'package:mindwrite/features/archive_feature/presentation/bloc/archive_event.dart';
import 'package:mindwrite/features/archive_feature/presentation/bloc/archive_state.dart';

import 'package:mindwrite/features/home_feature/data/model/note_model.dart';

import 'package:mindwrite/core/widgets/note_widget.dart';

class ArchiveView extends StatelessWidget {
  ArchiveView({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text(
          "Archive",
        ),
      ),
      drawer: const AppDrawer(),
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
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
                      BlocBuilder<ArchiveBloc, ArchiveState>(
                        builder: (context, state) {
                          if (state is ArchiveLoaded) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MasonryGridView.count(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 8,
                                  crossAxisSpacing: 10,
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.all(8.0),
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: state.archivedNotes.length,
                                  itemBuilder: (context, index) {
                                    NoteModel selectedNote =
                                        state.archivedNotes[index];
                                    return NoteWidget(
                                        selectedNote: selectedNote,
                                        onDismissed: () {
                                          bool undoPressed = false;
                                          SnackbarWidget.getSnackbar(
                                            context,
                                            "Note archived",
                                            "Undo",
                                            () {
                                              undoPressed = true;
                                              NoteModel simpleVersion =
                                                  selectedNote.copyWith(
                                                      archived: false);
                                              context.read<ArchiveBloc>().add(
                                                  ToggleOffArchiveEvent(
                                                      simpleVersion));
                                            },
                                            () {
                                              if (!undoPressed) {
                                                context.read<ArchiveBloc>().add(
                                                    ToggleOffArchiveEvent(
                                                        selectedNote));
                                              }
                                            },
                                          );
                                        });
                                  },
                                ),
                              ],
                            );
                          } else if (state is ArchiveLoadFailed) {
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
}
