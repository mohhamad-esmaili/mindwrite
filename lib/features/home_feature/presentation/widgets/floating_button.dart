import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindwrite/features/note_feature/presentation/bloc/note_bloc.dart';

class FloatingButtonWidget extends StatelessWidget {
  const FloatingButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 70,
      margin: const EdgeInsets.only(bottom: 10),
      child: FloatingActionButton(
          onPressed: () {
            context.read<NoteBloc>().add(const NoteInitialEvent());
            context.go('/create_note');
          },
          backgroundColor: const Color.fromRGBO(41, 42, 44, 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          child: ShaderMask(
            shaderCallback: (Rect bounds) {
              return LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
                stops: const [.3, .6, .9],
                colors: [
                  Colors.white,
                  Colors.blue[200]!,
                  Colors.blueAccent,
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
