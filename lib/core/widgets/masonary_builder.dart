import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:mindwrite/core/enums/listmode_enum.dart';
import 'package:mindwrite/core/resources/note_arguments.dart';
import 'package:mindwrite/core/usecase/background_changer.dart';
import 'package:mindwrite/core/utils/color_constants.dart';
import 'package:mindwrite/core/widgets/snackbar_widget.dart';
import 'package:mindwrite/features/note_feature/presentation/bloc/note_bloc.dart';
import 'package:mindwrite/features/shared_bloc/data/model/note_model.dart';
import 'package:mindwrite/features/shared_bloc/presentation/bloc/shared_bloc.dart';

class MasonaryBuilder extends StatefulWidget {
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

class _MasonaryBuilderState extends State<MasonaryBuilder>
    with AutomaticKeepAliveClientMixin {
  final Map<String, double> _opacityMap = {};
  @override
  bool get wantKeepAlive => true;
  final PageStorageBucket _bucket = PageStorageBucket();
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return PageStorage(
      bucket: _bucket,
      child: widget.noteModelList.isEmpty
          ? _buildEmptyStatus(context, widget.sharedBloc)
          : BlocBuilder<SharedBloc, SharedState>(
              bloc: widget.sharedBloc,
              builder: (context, state) {
                return MasonryGridView.count(
                  crossAxisCount:
                      widget.sharedBloc.listMode == ListModeEnum.multiple
                          ? 2
                          : 1,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 10,
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8.0),
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.noteModelList.length,
                  itemBuilder: (context, index) {
                    final NoteModel note = widget.noteModelList[index];
                    final double opacity = _opacityMap[note.id] ?? 1.0;

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
                        if (widget.sharedBloc.isSelectionMode == false) {
                          context
                              .read<NoteBloc>()
                              .add(RefreshNoteDataEvent(refreshedNote: note));
                          context.go("/create_note",
                              extra: NoteArguments(
                                  selectedNote: note, editMode: true));
                        } else {
                          widget.sharedBloc.add(TapItem(note));
                        }
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

                              widget.sharedBloc
                                  .add(ToggleArchiveEvent([simpleVersion]));

                              setState(() {
                                widget.noteModelList
                                    .insert(index, selectedNote);
                                _opacityMap[selectedNote.id!] = 1.0;
                              });
                            },
                            onClosed: () {
                              if (!undoPressed) {
                                widget.sharedBloc
                                    .add(ToggleArchiveEvent([selectedNote]));
                              }
                            },
                          );
                        },
                        child: AnimatedOpacity(
                          opacity: opacity,
                          duration: const Duration(milliseconds: 300),
                          child: _buildNoteTile(
                              context, note, widget.sharedBloc, isSelected),
                        ),
                        // Detect the dismiss progress and apply fade effect
                        onUpdate: (details) {
                          setState(() {
                            _opacityMap[note.id!] =
                                (1.0 - (details.progress + 0.2))
                                    .clamp(0.0, 1.0);
                          });
                        },
                      ),
                    )
                        .animate()
                        .fade(duration: const Duration(milliseconds: 300))
                        .slide(
                            duration: const Duration(milliseconds: 500),
                            begin: const Offset(0, 0.3),
                            end: Offset.zero,
                            curve: Curves.easeOut);
                  },
                );
              },
            ),
    );
  }

  Widget _buildEmptyStatus(BuildContext context, SharedBloc sharedBloc) {
    return Container(
      height: 150,
      width: double.infinity,
      margin: const EdgeInsetsDirectional.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: sharedBloc.themeMode == ThemeMode.light
            ? Colors.grey[100]
            : Colors.white12,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.sentiment_dissatisfied,
              size: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "There is no note yet",
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
          ],
        ),
      ),
    ).animate().fade(duration: const Duration(milliseconds: 300));
  }

  Widget _buildNoteTile(BuildContext context, NoteModel note,
      SharedBloc sharedBloc, bool isSelected) {
    Color initialColor = BackgroundChanger()
            .colorBackGroundChanger(note.noteBackground!, context) ??
        Colors.transparent;
    ThemeData themeData = Theme.of(context);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: initialColor,
        // color: note.noteBackground!.color == Colors.transparent
        //     ? sharedBloc.themeMode == ThemeMode.light
        //         ? AppColorConstants.containerLightColor
        //         : AppColorConstants.containerDarkColor
        //     : note.noteBackground!.color!,
        image: note.noteBackground!.darkBackgroundPath != null
            ? DecorationImage(
                image: AssetImage(BackgroundChanger()
                    .imageBackGroundChanger(note.noteBackground!, context)!),
                fit: BoxFit.cover,
              )
            : null,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected
              ? AppColorConstants.secondaryColor
              : (note.noteBackground!.darkColor == Colors.transparent
                  ? Colors.grey
                  : initialColor),
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
              style: themeData.textTheme.labelSmall,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              note.description!,
              maxLines: 15,
              style: themeData.textTheme.labelSmall,
            ),
          ),
          note.labels != null
              ? Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Wrap(
                    spacing: 8,
                    children: note.labels!.map((label) {
                      return IntrinsicWidth(
                        child: Container(
                          margin: const EdgeInsets.only(top: 5),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white60,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(label.labelName,
                                style: themeData.textTheme.labelSmall),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                )
              : const SizedBox.shrink(),
          note.noteBackground!.darkColor != Colors.transparent &&
                  note.noteBackground!.darkBackgroundPath != null
              ? Container(
                  width: 25,
                  height: 25,
                  margin: const EdgeInsets.only(left: 10, bottom: 10),
                  decoration: BoxDecoration(
                    color: initialColor,
                    border: Border.all(color: Colors.grey),
                    shape: BoxShape.circle,
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
