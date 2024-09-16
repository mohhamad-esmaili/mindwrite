import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:mindwrite/core/widgets/circular_indicator_widget.dart';
import 'package:mindwrite/features/note_feature/presentation/bloc/note_bloc.dart';
import 'package:mindwrite/features/note_feature/presentation/widgets/bottom_section/bottombar_section.dart';
import 'package:mindwrite/features/note_feature/presentation/widgets/note_appbar.dart';

class NoteView extends StatelessWidget {
  NoteView({super.key});

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteBloc, NoteState>(builder: (context, state) {
      if (state is NoteInitial) {
        Color initialColor = state.note.noteBackground!.color;
        String? initialBG = state.note.noteBackground!.backgroundPath;
        int descriptionLines = state.descriptionLines ?? 1;

        return PopScope(
          canPop: false,
          onPopInvoked: (didPop) => context.go("/home"),
          child: Scaffold(
            backgroundColor: initialColor,
            body: Stack(
              children: [
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: initialBG == null ? initialColor : null,
                      image: initialBG != null
                          ? DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(initialBG),
                            )
                          : null,
                    ),
                  ),
                ),
                SafeArea(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50,
                        child: NoteAppbar(
                          initialColor: Colors.transparent,
                          titleController: titleController,
                        ),
                      ),

                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 5),
                          child: Stack(
                            children: [
                              SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Title TextField
                                    TextField(
                                      controller: titleController,
                                      onChanged: (text) => context
                                          .read<NoteBloc>()
                                          .add(
                                            ChangeNoteEvent(
                                              decriptionTextEditingController:
                                                  descriptionController.text,
                                              titleTextEditingController:
                                                  titleController.text,
                                            ),
                                          ),
                                      maxLines: null,
                                      minLines: 1,
                                      keyboardType: TextInputType.multiline,
                                      decoration: const InputDecoration(
                                        hintText: "Title",
                                        hintStyle:
                                            TextStyle(color: Colors.white),
                                        disabledBorder: InputBorder.none,
                                        border: InputBorder.none,
                                      ),
                                    ),

                                    AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      height: descriptionLines * 24.0 + 16.0,
                                      child: TextField(
                                        controller: descriptionController,
                                        scrollPhysics:
                                            const NeverScrollableScrollPhysics(),
                                        onChanged: (text) {
                                          final int lines =
                                              '\n'.allMatches(text).length + 1;
                                          context.read<NoteBloc>().add(
                                                ChangeNoteEvent(
                                                  descriptionLines: lines,
                                                  decriptionTextEditingController:
                                                      descriptionController
                                                          .text,
                                                  titleTextEditingController:
                                                      titleController.text,
                                                ),
                                              );
                                        },
                                        maxLines: null,
                                        minLines: 1,
                                        keyboardType: TextInputType.multiline,
                                        decoration: const InputDecoration(
                                          hintText: "Description",
                                          hintStyle:
                                              TextStyle(color: Colors.white),
                                          disabledBorder: InputBorder.none,
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                    initialColor != Colors.transparent &&
                                            initialBG != null
                                        ? Container(
                                            width: 40,
                                            height: 40,
                                            padding: const EdgeInsets.all(8.0),
                                            decoration: BoxDecoration(
                                              color: initialColor,
                                              border: Border.all(
                                                color: Colors.grey,
                                              ),
                                              shape: BoxShape.circle,
                                              // borderRadius:
                                              //     BorderRadius.circular(8),
                                            ),
                                          )
                                        : const SizedBox.shrink(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Bottom bar
                      SizedBox(
                        height: 50,
                        child: BottombarWidget(
                          noteDateTime: state.note.lastUpdate,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }
      return const CircularIndicatorWidget();
    });
  }
}
