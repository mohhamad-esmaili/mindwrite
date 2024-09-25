import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mindwrite/core/utils/color_constants.dart';
import 'package:mindwrite/core/widgets/camera_capture.dart';
import 'package:mindwrite/features/note_feature/presentation/bloc/note_bloc.dart';
import 'package:mindwrite/features/shared_bloc/data/model/note_model.dart';
import 'package:mindwrite/locator.dart';

class HomeBottomBar extends StatelessWidget {
  const HomeBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'note',
      child: BottomAppBar(
        color: AppColorConstants.appbarDarkColor,
        notchMargin: 10,
        padding: const EdgeInsets.all(5),
        height: 70,
        shape: const CircularNotchedRectangle(),
        clipBehavior: Clip.antiAlias,
        child: Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.check_box_outlined,
                size: 30,
              ),
            ),
            IconButton(
              onPressed: () {
                context.read<NoteBloc>().add(NoteInitialEvent());
                context.go("/draw");
              },
              icon: const Icon(
                Icons.brush_rounded,
                size: 30,
              ),
            ),
            IconButton(
              onPressed: () async {
                Uint8List? selectedImage = await CameraCapture.openCamera(
                    context, ImageSource.gallery);

                if (context.mounted && selectedImage != null) {
                  context.read<NoteBloc>().add(NoteInitialEvent());
                  context
                      .read<NoteBloc>()
                      .add(ChangeDrawingLists(selectedImage));

                  context.go("/create_note");
                }
              },
              icon: const Icon(
                Icons.image_outlined,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
