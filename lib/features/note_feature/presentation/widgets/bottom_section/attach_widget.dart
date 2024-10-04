import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mindwrite/core/usecase/background_changer.dart';
import 'package:mindwrite/core/widgets/camera_capture.dart';
import 'package:mindwrite/features/note_feature/presentation/bloc/note_bloc.dart';

/// this widget contains left three dots icon which allow us to share or delete note
class AtachButtonWidget extends StatelessWidget {
  const AtachButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteBloc, NoteState>(
      builder: (context, state) {
        if (state is NoteInitial) {
          Color? initialColor = BackgroundChanger()
              .colorBackGroundChanger(state.note.noteBackground!, context);
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
                  context: context,
                  onPress: () async {
                    Uint8List? selectedImage = await CameraCapture.openCamera(
                        context, ImageSource.camera);

                    if (context.mounted && selectedImage != null) {
                      context
                          .read<NoteBloc>()
                          .add(ChangeDrawingLists(selectedImage));
                    }
                    if (context.mounted) {
                      context.pop();
                    }
                  },
                  label: "Take photo",
                  icon: Icons.photo_camera_outlined,
                ),
                _makeSettingButton(
                  context: context,
                  onPress: () async {
                    Uint8List? selectedImage = await CameraCapture.openCamera(
                        context, ImageSource.gallery);

                    if (context.mounted && selectedImage != null) {
                      context
                          .read<NoteBloc>()
                          .add(ChangeDrawingLists(selectedImage));
                    }

                    if (context.mounted) {
                      context.pop();
                    }
                  },
                  label: "Add image",
                  icon: Icons.image_outlined,
                ),
                _makeSettingButton(
                  context: context,
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
