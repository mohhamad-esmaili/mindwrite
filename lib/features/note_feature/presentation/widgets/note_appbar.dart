import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mindwrite/core/widgets/snackbar_widget.dart';
import 'package:mindwrite/features/home_feature/presentation/bloc/home_bloc.dart';
import 'package:mindwrite/features/note_feature/presentation/bloc/note_bloc.dart';
import 'package:mindwrite/features/shared_bloc/presentation/bloc/shared_bloc.dart';

class NoteAppbar extends StatelessWidget {
  final TextEditingController titleController;
  final bool selectedNote;
  final Color initialColor;
  const NoteAppbar(
      {super.key,
      required this.initialColor,
      required this.titleController,
      required this.selectedNote});

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return BlocBuilder<NoteBloc, NoteState>(
      builder: (context, state) {
        if (state is NoteInitial) {
          return AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: initialColor,
            leading: IconButton(
                onPressed: () {
                  if (titleController.text.isNotEmpty) {
                    context
                        .read<NoteBloc>()
                        .add(SaveNoteEvent(state.note, selectedNote));
                    context.read<NoteBloc>().add(const ClearNoteDataEvent());

                    context.read<HomeBloc>().add(LoadAllNotes());
                  }

                  context.go('/home');
                },
                icon: Icon(
                  Icons.arrow_back_rounded,
                  color: themeData.iconTheme.color,
                )),
            actions: [
              BlocBuilder<NoteBloc, NoteState>(builder: (context, state) {
                if (state is NoteInitial) {
                  return IconButton(
                    onPressed: () {
                      context
                          .read<NoteBloc>()
                          .add(ChangeNotePinEvent(!state.note.pin));
                    },
                    icon: Icon(
                      state.note.pin
                          ? Icons.push_pin_rounded
                          : Icons.push_pin_outlined,
                      color: themeData.iconTheme.color,
                    ),
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              }),
              IconButton(
                onPressed: () {
                  if (titleController.text.isNotEmpty) {
                    context
                        .read<NoteBloc>()
                        .add(NoteArchiveEvent(!state.note.archived));
                    context.go('/home');
                    SnackbarService.showStatusSnackbar(
                        context: context,
                        message: "Note Archived",
                        actionLabel: "Undo",
                        onAction: () {
                          context
                              .read<SharedBloc>()
                              .add(ToggleArchiveEvent([state.note]));
                        },
                        onClosed: null);
                  } else {
                    SnackbarService.showStatusSnackbar(
                        context: context,
                        message: "Enter note title!",
                        actionLabel: "Ok",
                        onAction: null,
                        onClosed: null);
                  }
                },
                icon: Icon(
                  Icons.archive_outlined,
                  color: themeData.iconTheme.color,
                ),
              ),
            ],
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
