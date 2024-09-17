import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mindwrite/core/utils/color_constants.dart';
import 'package:mindwrite/features/note_feature/presentation/bloc/note_bloc.dart';

class HomeBottomBar extends StatelessWidget {
  const HomeBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
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
              size: 35,
            ),
          ),
          IconButton(
            onPressed: () {
              context.go("/create_note");
              context.go("/draw");
            },
            icon: const Icon(
              Icons.brush_rounded,
              size: 35,
            ),
          ),
        ],
      ),
    );
  }
}
