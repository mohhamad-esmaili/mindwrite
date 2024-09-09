import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:mindwrite/core/utils/color_constants.dart';
import 'package:mindwrite/core/widgets/circular_indicator_widget.dart';
import 'package:mindwrite/features/home_feature/presentation/bloc/home_bloc.dart';
import 'package:mindwrite/features/note_feature/presentation/bloc/note_bloc.dart';
import 'package:mindwrite/features/note_feature/presentation/widgets/bottombar_widget.dart';
import 'package:mindwrite/features/note_feature/presentation/widgets/note_appbar.dart';

class NoteView extends StatelessWidget {
  NoteView({super.key});
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    context.read<NoteBloc>().add(NoteInitialEvent());
    return BlocBuilder<NoteBloc, NoteState>(builder: (context, state) {
      if (state is NoteInitial) {
        Color initialColor = state.note.noteBackground!.color;

        return Scaffold(
            backgroundColor: initialColor,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: NoteAppbar(
                initialColor: initialColor,
                titleController: titleController,
              ),
            ),
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: TextField(
                      controller: titleController,
                      onChanged: (text) => context
                          .read<NoteBloc>()
                          .add(ChangeNoteEvent(
                            decriptionTextEditingController:
                                descriptionController.text,
                            titleTextEditingController: titleController.text,
                          )),
                      maxLines: null,
                      minLines: 1,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        hintText: "Title",
                        hintStyle: TextStyle(color: Colors.white),
                        disabledBorder: InputBorder.none,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: descriptionController,
                      onChanged: (text) => context
                          .read<NoteBloc>()
                          .add(ChangeNoteEvent(
                            decriptionTextEditingController:
                                descriptionController.text,
                            titleTextEditingController: titleController.text,
                          )),
                      maxLines: null,
                      minLines: 1,
                      contentInsertionConfiguration:
                          ContentInsertionConfiguration(
                        onContentInserted: (_) {/*your cb here*/},
                        allowedMimeTypes: [
                          "image/png", /*...*/
                        ],
                      ),
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        hintText: "Description",
                        hintStyle: TextStyle(color: Colors.white),
                        disabledBorder: InputBorder.none,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: BottombarWidget(
              noteDateTime: state.note.lastUpdate,
            ));
      }
      return const CircularIndicatorWidget();
    });
  }
}
