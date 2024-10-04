import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindwrite/core/resources/note_arguments.dart';
import 'package:mindwrite/core/utils/color_constants.dart';
import 'package:mindwrite/features/note_feature/presentation/bloc/note_bloc.dart';
import 'package:mindwrite/features/shared_bloc/data/model/note_model.dart';

import 'package:mindwrite/features/shared_bloc/presentation/bloc/shared_bloc.dart';
import 'package:mindwrite/locator.dart';

class FloatingButtonWidget extends StatelessWidget {
  const FloatingButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      width: 65,
      margin: const EdgeInsets.only(bottom: 10),
      child: FloatingActionButton(
          onPressed: () {
            context.read<NoteBloc>().add(const NoteInitialEvent());
            context.go('/create_note',
                extra: NoteArguments(selectedNote: locator<NoteModel>()));
          },
          backgroundColor:
              context.read<SharedBloc>().themeMode == ThemeMode.light
                  ? AppColorConstants.lightFloatingButtonColor
                  : AppColorConstants.darkFloatingButtonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: ShaderMask(
            shaderCallback: (Rect bounds) {
              return const LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
                stops: [.4, .4, .8],
                colors: [
                  Colors.green,
                  Colors.blueAccent,
                  Colors.red,
                ],
              ).createShader(bounds);
            },
            child: const Icon(
              Icons.add,
              size: 55,
              color: Colors.white,
            ),
          )),
    );
  }
}
