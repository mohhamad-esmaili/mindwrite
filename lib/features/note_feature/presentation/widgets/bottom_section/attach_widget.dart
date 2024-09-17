import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mindwrite/features/note_feature/presentation/bloc/note_bloc.dart';

/// this widget contains left three dots icon which allow us to share or delete note
class AtachButtonWidget extends StatelessWidget {
  const AtachButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteBloc, NoteState>(
      builder: (context, state) {
        if (state is NoteInitial) {
          Color initialColor = state.note.noteBackground!.color;
          return Container(
            color: initialColor == Colors.transparent
                ? Colors.grey[800]
                : initialColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _makeSettingButton(
                  onPress: () {
                    context.pop();
                    context.go('/draw');
                  },
                  label: "Drawing",
                  icon: Icons.brush_rounded,
                ),
              ],
            ),
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }

  Widget _makeSettingButton({
    required Function onPress,
    required String label,
    required IconData icon,
  }) =>
      TextButton.icon(
        onPressed: () => onPress(),
        icon: Icon(icon, color: Colors.white),
        label: Text(
          label,
          style: const TextStyle(color: Colors.white),
        ),
        style: TextButton.styleFrom(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.zero)),
          overlayColor: Colors.white.withOpacity(0.1),
        ),
      );
}
