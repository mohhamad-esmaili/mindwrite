import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mindwrite/core/gen/assets.gen.dart';
import 'package:mindwrite/core/usecase/date_formater.dart';
import 'package:mindwrite/core/utils/color_constants.dart';
import 'package:mindwrite/core/utils/note_constants.dart';
import 'package:mindwrite/features/home_feature/presentation/bloc/home_bloc.dart';
import 'package:mindwrite/features/note_feature/presentation/bloc/note_bloc.dart';
import 'package:mindwrite/features/note_feature/presentation/widgets/bottom_section/attach_widget.dart';
import 'package:mindwrite/features/note_feature/presentation/widgets/bottom_section/threedots_widget.dart';
import 'package:mindwrite/features/note_feature/presentation/widgets/bottom_section/palette_widget.dart';

class BottombarWidget extends StatelessWidget {
  final DateTime noteDateTime;

  const BottombarWidget({super.key, required this.noteDateTime});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(
              Icons.add_box_outlined,
              color: Colors.white,
            ),
            onPressed: () => showModalBottomSheet<void>(
              context: context,
              elevation: 2,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
              builder: (BuildContext context) => const AtachButtonWidget(),
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.palette_outlined,
              color: Colors.white,
            ),
            onPressed: () => showModalBottomSheet<void>(
              context: context,
              elevation: 2,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
              builder: (BuildContext context) => const PaletteButtonWidget(),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 6.5),
              child: Text(
                DateFormater.changeDateEdited(noteDateTime),

                style: const TextStyle(
                  color: Colors.white,
                ),
                // textAlign: TextAlign.center,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.more_vert_rounded, color: Colors.white),
            onPressed: () => showModalBottomSheet<void>(
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
              builder: (context) => const ThreeDotsButtonWidget(),
            ),
          ),
        ],
      ),
    );
  }
}
