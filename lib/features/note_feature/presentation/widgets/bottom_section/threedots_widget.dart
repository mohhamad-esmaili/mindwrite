import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mindwrite/core/usecase/background_changer.dart';
import 'package:mindwrite/core/usecase/copy_clipboard.dart';
import 'package:mindwrite/core/widgets/share_service.dart';

import 'package:mindwrite/features/note_feature/presentation/bloc/note_bloc.dart';
import 'package:mindwrite/features/shared_bloc/presentation/bloc/shared_bloc.dart';

/// this widget contains left three dots icon which allow us to share or delete note
class ThreeDotsButtonWidget extends StatelessWidget {
  const ThreeDotsButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteBloc, NoteState>(
      builder: (context, state) {
        if (state is NoteInitial) {
          Color? initialColor = BackgroundChanger()
              .colorBackGroundChanger(state.note.noteBackground!, context);
          return Container(
            color: initialColor == Colors.transparent
                ? Theme.of(context).appBarTheme.backgroundColor
                : initialColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _makeSettingButton(
                  context: context,
                  onPress: () {
                    BlocProvider.of<SharedBloc>(context)
                        .add(DeleteNoteEvent([state.note]));
                    context.pop();
                    context.go('/home');
                  },
                  label: "Delete",
                  icon: Icons.delete,
                ),
                _makeSettingButton(
                  context: context,
                  onPress: () {
                    if (state.note.title != null) {
                      CopyClipboardService.copyNoteToClipboard(
                          state.note.title!, state.note.description, context);
                    }

                    context.pop();
                  },
                  label: "Make a copy",
                  icon: Icons.copy_rounded,
                ),
                _makeSettingButton(
                  context: context,
                  onPress: () {
                    ShareService.sendTo(state.note, context);
                    context.pop();
                  },
                  label: "Send",
                  icon: Icons.share_rounded,
                ),
                _makeSettingButton(
                  context: context,
                  onPress: () {
                    context.go("/label_selection", extra: state.note);
                    context.pop();
                  },
                  label: "Labels",
                  icon: Icons.label_outline_rounded,
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
    required BuildContext context,
    required Function onPress,
    required String label,
    required IconData icon,
  }) {
    ThemeData themeData = Theme.of(context);
    return TextButton.icon(
      onPressed: () => onPress(),
      icon: Icon(icon, color: themeData.iconTheme.color),
      label: Text(
        label,
        style: themeData.textTheme.labelMedium,
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
}
