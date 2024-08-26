import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mindwrite/core/utils/color_constants.dart';
import 'package:mindwrite/features/note_feature/bloc/note_bloc.dart';
import 'package:mindwrite/features/note_feature/widgets/bottombar_widget.dart';

class NoteView extends StatelessWidget {
  const NoteView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteBloc, NoteState>(builder: (context, state) {
      // final backgroundColor = (state is NoteInitial) ? state.initialColor : Colors.white;
      if (state is NoteInitial) {
        return Scaffold(
            backgroundColor: state.initialColor,
            appBar: AppBar(
              automaticallyImplyLeading: true,
              backgroundColor: state.initialColor,
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.push_pin_rounded),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.archive_outlined),
                ),
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: TextField(
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
                      maxLines: null,
                      minLines: 1,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        hintText: "Description",
                        hintStyle: TextStyle(color: Colors.white),
                        disabledBorder: InputBorder.none,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                    child: Text("data"),
                  )
                ],
              ),
            ),
            bottomNavigationBar: BottombarWidget());
      }
      return CircularProgressIndicator();
    });
  }
}
