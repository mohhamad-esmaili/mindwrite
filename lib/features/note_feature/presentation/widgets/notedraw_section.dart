import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mindwrite/core/widgets/circular_indicator_widget.dart';
import 'package:mindwrite/core/widgets/snackbar_widget.dart';
import 'package:mindwrite/features/note_feature/presentation/bloc/note_bloc.dart';

class NoteDrawSectionWidget extends StatelessWidget {
  const NoteDrawSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteBloc, NoteState>(
      builder: (context, state) {
        if (state is NoteSaving) {
          return CircularIndicatorWidget();
        }
        if (state is NoteInitial) {
          List<Uint8List>? allPaints = state.note.drawingsList;

          // Get the width of the screen
          double screenWidth = MediaQuery.of(context).size.width;

          if (allPaints != null && allPaints.isNotEmpty) {
            return Center(
              child: SizedBox(
                height: 400,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1, // Each item takes one full row
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    childAspectRatio: screenWidth / 350, // Full width
                  ),
                  itemCount: allPaints.length,
                  scrollDirection: Axis.horizontal, // Horizontal scrolling
                  itemBuilder: (BuildContext context, int index) {
                    Uint8List selectedPaint = allPaints[index];
                    return Container(
                      width: screenWidth, // Full width of the screen
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                      child: Stack(
                        children: [
                          Image.memory(
                            selectedPaint,
                            alignment: Alignment.center,
                            fit: BoxFit.contain,
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: IconButton(
                              style: IconButton.styleFrom(
                                  backgroundColor: Colors.grey[200]),
                              icon: Icon(
                                Icons.delete,
                                size: 25,
                                color: Colors.red[400],
                              ),
                              onPressed: () => SnackbarService.showAskingDialog(
                                context: context,
                                questionText: "Are You Sure?",
                                onYesBTNText: "Yes",
                                onYesPress: () {
                                  context
                                      .read<NoteBloc>()
                                      .add(RemovePaintEvent(selectedPaint));
                                  context.pop();
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            );
          } else {
            return SizedBox.shrink(); // Return empty if there are no drawings
          }
        } else {
          return const CircularIndicatorWidget();
        }
      },
    );
  }
}
