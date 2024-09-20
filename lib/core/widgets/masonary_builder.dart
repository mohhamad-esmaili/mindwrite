import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mindwrite/core/utils/color_constants.dart';
import 'package:mindwrite/core/widgets/snackbar_widget.dart';
import 'package:mindwrite/features/shared_bloc/data/model/note_model.dart';
import 'package:mindwrite/features/shared_bloc/presentation/bloc/shared_bloc.dart';

class MasonaryBuilder extends StatefulWidget {
  /// should pass sharedbloc to manage them
  final SharedBloc sharedBloc;

  final List<NoteModel> noteModelList;

  /// if the notes should be sent to archive screen and set to true
  final bool defaultArchiveNote;

  /// using this method in delete screen
  /// its `false` by default
  final bool deleteScreen;

  const MasonaryBuilder({
    super.key,
    required this.sharedBloc,
    required this.noteModelList,
    required this.defaultArchiveNote,
    this.deleteScreen = false,
  });

  @override
  State<MasonaryBuilder> createState() => _MasonaryBuilderState();
}

class _MasonaryBuilderState extends State<MasonaryBuilder> {
  final Map<String, double> _opacityMap = {};

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 8,
      crossAxisSpacing: 10,
      shrinkWrap: true,
      padding: const EdgeInsets.all(8.0),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.noteModelList.length,
      itemBuilder: (context, index) {
        final NoteModel note = widget.noteModelList[index];
        final double opacity = _opacityMap[note.id] ?? 1.0;

        return BlocBuilder<SharedBloc, SharedState>(
          bloc: widget.sharedBloc,
          builder: (context, state) {
            final bool isSelected =
                widget.sharedBloc.selectedItems.contains(note);

            return InkWell(
              borderRadius: BorderRadius.circular(12),
              enableFeedback: isSelected ? false : true,
              highlightColor: Colors.white12,
              splashColor: Colors.white12,
              onLongPress: () {
                widget.sharedBloc.add(LongPressItem(note));
              },
              onTap: () {
                widget.sharedBloc.add(TapItem(note));
              },
              child: Dismissible(
                direction: widget.deleteScreen
                    ? DismissDirection.none
                    : DismissDirection.horizontal,
                key: Key('dismiss_${note.id}_$index'),
                onDismissed: (direction) async {
                  bool undoPressed = false;

                  NoteModel selectedNote = widget.noteModelList[index];

                  setState(() {
                    widget.noteModelList.removeAt(index);
                    _opacityMap.remove(selectedNote.id);
                  });

                  await SnackbarService.showStatusSnackbar(
                    context: context,
                    message: "Note archived",
                    actionLabel: "Undo",
                    onAction: () {
                      undoPressed = true;

                      NoteModel simpleVersion = selectedNote.copyWith(
                          archived: widget.defaultArchiveNote);
                      widget.sharedBloc.add(ToggleArchiveEvent(simpleVersion));

                      setState(() {
                        widget.noteModelList.insert(index, selectedNote);
                        _opacityMap[selectedNote.id!] = 1.0;
                      });
                    },
                    onClosed: () {
                      if (!undoPressed) {
                        widget.sharedBloc.add(ToggleArchiveEvent(selectedNote));
                      }
                    },
                  );
                },
                child: AnimatedOpacity(
                  opacity: opacity,
                  duration: const Duration(milliseconds: 300),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 100),
                    curve: Curves.easeInOut,
                    decoration: BoxDecoration(
                      color: note.noteBackground!.color,
                      image: note.noteBackground!.backgroundPath != null
                          ? DecorationImage(
                              image: AssetImage(
                                  note.noteBackground!.backgroundPath!),
                              fit: BoxFit.cover,
                            )
                          : null,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected
                            ? AppColorConstants.secondaryColor
                            : (note.noteBackground!.color == Colors.transparent
                                ? Colors.grey
                                : note.noteBackground!.color!),
                        width: isSelected ? 3 : 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            note.title!,
                            maxLines: 4,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            note.description!,
                            maxLines: 15,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        note.noteBackground!.color != Colors.transparent &&
                                note.noteBackground!.backgroundPath != null
                            ? Container(
                                width: 25,
                                height: 25,
                                margin:
                                    const EdgeInsets.only(left: 10, bottom: 10),
                                decoration: BoxDecoration(
                                  color: note.noteBackground!.color,
                                  border: Border.all(color: Colors.grey),
                                  shape: BoxShape.circle,
                                ),
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                  ),
                ),
                // Detect the dismiss progress and apply fade effect
                onUpdate: (details) {
                  setState(() {
                    _opacityMap[note.id!] =
                        (1.0 - (details.progress + 0.2)).clamp(0.0, 1.0);
                  });
                },
              ),
            );
          },
        );
      },
    );
  }
}
