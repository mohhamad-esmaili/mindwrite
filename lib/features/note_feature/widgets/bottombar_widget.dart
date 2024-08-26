import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindwrite/core/utils/color_constants.dart';
import 'package:mindwrite/features/note_feature/bloc/note_bloc.dart';

// this widget is bottom of add note
// color palete, last update and more are in this widget
class BottombarWidget extends StatelessWidget {
  const BottombarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(Icons.palette_outlined),
            onPressed: () => showModalBottomSheet<void>(
              context: context,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
              builder: (BuildContext context) {
                return BlocBuilder<NoteBloc, NoteState>(
                  builder: (context, state) {
                    if (state is NoteInitial) {
                      return Container(
                        height: 100,
                        color: state.initialColor == Colors.transparent
                            ? Colors.grey[800]
                            : state.initialColor,
                        child: Center(
                          child: ListView.builder(
                            itemCount: colorConstants.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              Color itemColor = colorConstants[index].color;

                              return InkWell(
                                onTap: () {
                                  context
                                      .read<NoteBloc>()
                                      .add(ChangeNoteColorEvent(itemColor));
                                },
                                child: Container(
                                  width: 50,
                                  margin: EdgeInsets.only(left: 10),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: index == 0
                                        ? Colors.grey[800]
                                        : itemColor,
                                    border: Border.all(
                                      color: state.initialColor == itemColor
                                          ? Colors.white
                                          : Colors.transparent,
                                      width: 3,
                                    ),
                                  ),
                                  child: AnimatedSwitcher(
                                    duration: Duration(milliseconds: 300),
                                    transitionBuilder: (Widget child,
                                        Animation<double> animation) {
                                      return ScaleTransition(
                                          scale: animation, child: child);
                                    },
                                    child: state.initialColor == itemColor
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
            ),
          )
        ],
      ),
    );
  }
}
