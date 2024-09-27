import 'package:flutter/material.dart';
import 'package:mindwrite/core/usecase/date_formater.dart';
import 'package:mindwrite/features/note_feature/presentation/widgets/bottom_section/attach_widget.dart';
import 'package:mindwrite/features/note_feature/presentation/widgets/bottom_section/threedots_widget.dart';
import 'package:mindwrite/features/note_feature/presentation/widgets/bottom_section/palette_widget.dart';

class BottombarWidget extends StatelessWidget {
  final DateTime noteDateTime;

  const BottombarWidget({super.key, required this.noteDateTime});

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(
              Icons.add_box_outlined,
              color: themeData.iconTheme.color,
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
            icon: Icon(
              Icons.palette_outlined,
              color: themeData.iconTheme.color,
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

                style: themeData.textTheme.labelSmall,
                // textAlign: TextAlign.center,
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.more_vert_rounded,
              color: themeData.iconTheme.color,
            ),
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
