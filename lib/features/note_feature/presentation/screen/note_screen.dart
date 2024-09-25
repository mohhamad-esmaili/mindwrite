import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:mindwrite/core/widgets/circular_indicator_widget.dart';
import 'package:mindwrite/features/label_feature/data/model/label_model.dart';
import 'package:mindwrite/features/note_feature/presentation/bloc/note_bloc.dart';
import 'package:mindwrite/features/note_feature/presentation/widgets/bottom_section/bottombar_section.dart';
import 'package:mindwrite/features/note_feature/presentation/widgets/note_appbar.dart';
import 'package:mindwrite/features/note_feature/presentation/widgets/notedraw_section.dart';
import 'package:mindwrite/features/shared_bloc/data/model/note_model.dart';

class NoteView extends StatefulWidget {
  final NoteModel? selectedNote;
  const NoteView({super.key, this.selectedNote});

  @override
  NoteViewState createState() => NoteViewState();
}

class NoteViewState extends State<NoteView> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.selectedNote!.title);
    descriptionController =
        TextEditingController(text: widget.selectedNote!.description);
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // context
    //     .read<NoteBloc>()
    //     .add(RefreshNoteDataEvent(refreshedNote: widget.selectedNote));
    return BlocBuilder<NoteBloc, NoteState>(builder: (context, state) {
      if (state is NoteSaving) {
        return const CircularIndicatorWidget();
      }
      if (state is NoteInitial) {
        Color initialColor = state.note.noteBackground!.color!;
        String? initialBG = state.note.noteBackground!.backgroundPath;
        int descriptionLines = state.descriptionLines ?? 1;

        return Scaffold(
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
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        child: Stack(
                          children: [
                            SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 300),
                                    switchInCurve: Curves.easeIn,
                                    switchOutCurve: Curves.easeOut,
                                    child: state.note.drawingsList != null &&
                                            state.note.drawingsList!.isNotEmpty
                                        ? const NoteDrawSectionWidget()
                                        : const SizedBox.shrink(),
                                  ),
                                  Hero(
                                    tag: 'note',
                                    child: TextField(
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
                                  ),
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
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
                                                    descriptionController.text,
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
                                  state.note.labels != null
                                      ? Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Wrap(
                                            spacing: 8,
                                            children:
                                                state.note.labels!.map((label) {
                                              return IntrinsicWidth(
                                                child: InkWell(
                                                  onTap: () => context.go(
                                                      "/label_selection",
                                                      extra: state.note),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            top: 5),
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 10,
                                                      vertical: 8,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white30,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        10,
                                                      ),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        label.labelName,
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 15),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                                  initialColor != Colors.transparent &&
                                          initialBG != null
                                      ? Container(
                                          width: 40,
                                          height: 40,
                                          padding: const EdgeInsets.all(8.0),
                                          decoration: BoxDecoration(
                                            color: initialColor,
                                            border:
                                                Border.all(color: Colors.grey),
                                            shape: BoxShape.circle,
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
        );
      }
      return const CircularIndicatorWidget();
    });
  }
}
