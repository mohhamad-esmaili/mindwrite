import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mindwrite/features/note_feature/presentation/bloc/note_bloc.dart';

class NoteAppbar extends StatelessWidget {
  final Color initialColor;
  final TextEditingController titleController;
  const NoteAppbar(
      {super.key, required this.initialColor, required this.titleController});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteBloc, NoteState>(
      builder: (context, state) {
        if (state is NoteInitial) {
          return AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: initialColor,
            leading: IconButton(
                onPressed: () {
                  if (titleController.text.isNotEmpty) {
                    context.read<NoteBloc>().add(SaveNoteEvent(state.note));
                  }

                  context.go('/');
                },
                icon: Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.white,
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
                      color: Colors.white,
                    ),
                  );
                } else {
                  return CircularProgressIndicator();
                }
              }),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.archive_outlined),
              ),
            ],
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
