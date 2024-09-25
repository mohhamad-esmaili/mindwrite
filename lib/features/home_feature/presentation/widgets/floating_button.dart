import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindwrite/features/note_feature/presentation/bloc/note_bloc.dart';
import 'package:mindwrite/features/shared_bloc/data/model/note_model.dart';
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
            context.go('/create_note');
          },
          backgroundColor: const Color.fromRGBO(41, 42, 44, 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: ShaderMask(
            shaderCallback: (Rect bounds) {
              return LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
                stops: const [.4, .4, .8],
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
