import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mindwrite/core/usecase/date_formater.dart';
import 'package:mindwrite/core/utils/color_constants.dart';
import 'package:mindwrite/features/note_feature/presentation/bloc/note_bloc.dart';

class BottombarWidget extends StatelessWidget {
  final DateTime noteDateTime;
  const BottombarWidget({super.key, required this.noteDateTime});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Row(
        children: [
          IconButton(
              icon: Icon(
                Icons.palette_outlined,
                color: Colors.white,
              ),
              onPressed: () => getPaleteBottomSheet(context)),
          Expanded(
            child: Text(
              DateFormater.changeDateEdited(noteDateTime),
              style: TextStyle(
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          IconButton(
              onPressed: () => getMoreSettingsBottomSheet(context),
              icon: Icon(Icons.more_vert_rounded))
        ],
      ),
    );
  }

  Future<void> getPaleteBottomSheet(BuildContext context) =>
      showModalBottomSheet<void>(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        builder: (BuildContext context) {
          return BlocBuilder<NoteBloc, NoteState>(
            builder: (context, state) {
              if (state is NoteInitial) {
                Color initialColor = state.note.noteBackground!.color;
                return Container(
                  height: 100,
                  color: initialColor == Colors.transparent
                      ? Colors.grey[800]
                      : initialColor,
                  child: Center(
                    child: ListView.builder(
                      itemCount: ColorConstants.noteColors.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        Color itemColor =
                            ColorConstants.noteColors[index].color;

                        return InkWell(
                          onTap: () {
                            context
                                .read<NoteBloc>()
                                .add(ChangeNoteColorEvent(itemColor));
                          },
                          child: Container(
                            width: 50,
                            margin: EdgeInsets.only(left: 20),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: index == 0 ? Colors.grey[800] : itemColor,
                              border: Border.all(
                                color: initialColor == itemColor
                                    ? Colors.white
                                    : Colors.transparent,
                                width: 3,
                              ),
                            ),
                            child: AnimatedSwitcher(
                              duration: Duration(milliseconds: 300),
                              transitionBuilder:
                                  (Widget child, Animation<double> animation) {
                                return ScaleTransition(
                                    scale: animation, child: child);
                              },
                              child: initialColor == itemColor
                                  ? Icon(
                                      Icons.check,
                                      key: ValueKey("check_${index}"),
                                      color: Colors.white,
                                    )
                                  : index == 0
                                      ? Icon(
                                          Icons.invert_colors_off_rounded,
                                          key: ValueKey("empty${index}"),
                                          color: Colors.white,
                                        )
                                      : SizedBox(
                                          key: ValueKey("empty_${index}"),
                                        ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              }
              return CircularProgressIndicator();
            },
          );
        },
      );
  Future<void> getMoreSettingsBottomSheet(BuildContext context) =>
      showModalBottomSheet<void>(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        builder: (BuildContext context) {
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
                      makeSettingButton(
                          onPress: () {
                            context.go('/');
                          },
                          label: "Delete",
                          icon: Icons.delete),
                      // TODO: share in social media
                      // shared plus has error here to build
                      makeSettingButton(
                          onPress: () {},
                          label: "Send",
                          icon: Icons.share_rounded),
                    ],
                  ),
                );
              }
              return CircularProgressIndicator();
            },
          );
        },
      );
  Widget makeSettingButton(
          {required Function onPress,
          required String label,
          required IconData icon}) =>
      TextButton.icon(
        onPressed: () => onPress,
        icon: Icon(
          icon,
          color: Colors.white,
        ),
        label: Text(
          label,
          style: TextStyle(color: Colors.white),
        ),
        style: TextButton.styleFrom(
          padding: EdgeInsets.only(right: 10, left: 10, top: 10, bottom: 10),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.zero)),
          overlayColor: Colors.white,
          alignment: Alignment.topLeft,
        ),
      );
}
