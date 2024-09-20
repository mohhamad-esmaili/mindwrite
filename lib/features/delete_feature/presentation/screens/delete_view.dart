import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mindwrite/core/widgets/app_drawer.dart';
import 'package:mindwrite/core/widgets/masonary_builder.dart';
import 'package:mindwrite/core/widgets/screens_appbar.dart';
import 'package:mindwrite/core/widgets/snackbar_widget.dart';
import 'package:mindwrite/features/delete_feature/presentation/bloc/delete_bloc.dart';
import 'package:mindwrite/features/delete_feature/presentation/bloc/delete_event.dart';
import 'package:mindwrite/features/delete_feature/presentation/bloc/delete_state.dart';

import 'package:mindwrite/features/shared_bloc/data/model/note_model.dart';
import 'package:mindwrite/features/shared_bloc/presentation/bloc/shared_bloc.dart';

class DeleteView extends StatefulWidget {
  const DeleteView({super.key});

  @override
  State<DeleteView> createState() => _DeleteViewState();
}

class _DeleteViewState extends State<DeleteView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Fetch latest notes when screen is loaded or refreshed
    context.read<DeleteBloc>().add(const GetAllDeleted());
  }

  @override
  Widget build(BuildContext context) {
    SharedBloc sharedBloc = BlocProvider.of<SharedBloc>(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: ScreensAppbar(
        appbarTitle: "Deleted",
        sharedBloc: sharedBloc,
        isRestoreMode: true,
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
                                  // onDismissed: (index) async {
                                  //   NoteModel selectedNote =
                                  //       state.deletedNotes[index];
                                  //   bool undoPressed = false;

                                  //   // final archiveBloc =
                                  //   //     context.read<DeleteBloc>();
                                  //   // archiveBloc.add(ToggleOffArchiveEvent(
                                  //   //     selectedNote));
                                  //   if (context.mounted) {
                                  //     await SnackbarService.showStatusSnackbar(
                                  //       context: context,
                                  //       message: "Note archived",
                                  //       actionLabel: "Undo",
                                  //       onAction: () {
                                  //         undoPressed = true;
                                  //         NoteModel simpleVersion = selectedNote
                                  //             .copyWith(archived: false);
                                  //         // archiveBloc.add(
                                  //         //     ToggleOffArchiveEvent(
                                  //         //         simpleVersion));
                                  //       },
                                  //       onClosed: () {
                                  //         if (!undoPressed) {
                                  //           // archiveBloc.add(
                                  //           //     ToggleOffArchiveEvent(
                                  //           //         selectedNote));
                                  //         }
                                  //       },
                                  //     );
                                  //   }
                                  // },
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
}
