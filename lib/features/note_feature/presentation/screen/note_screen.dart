import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mindwrite/core/usecase/background_changer.dart';
import 'package:mindwrite/core/utils/note_constants.dart';

import 'package:mindwrite/core/widgets/circular_indicator_widget.dart';
import 'package:mindwrite/features/note_feature/presentation/bloc/note_bloc.dart';
import 'package:mindwrite/features/note_feature/presentation/widgets/bottom_section/bottombar_section.dart';
import 'package:mindwrite/features/note_feature/presentation/widgets/note_appbar.dart';
import 'package:mindwrite/features/note_feature/presentation/widgets/notedraw_section.dart';
import 'package:mindwrite/features/shared_bloc/data/model/note_model.dart';

class NoteView extends StatefulWidget {
  final NoteModel? selectedNote;
  final bool? editMode;
  const NoteView({super.key, this.selectedNote, this.editMode = false});

  @override
  NoteViewState createState() => NoteViewState();
}

class NoteViewState extends State<NoteView> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  int descriptionLines = 1; // تعداد خطوط توصیف

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.selectedNote!.title);
    descriptionController =
        TextEditingController(text: widget.selectedNote!.description);
    descriptionController
        .addListener(_calculateLines); // لیسنر برای محاسبه خطوط
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.removeListener(_calculateLines);
    descriptionController.dispose();
    super.dispose();
  }

  // تابعی برای محاسبه تعداد خطوط واقعی
  void _calculateLines() {
    final span = TextSpan(
      text: descriptionController.text,
      style: Theme.of(context).textTheme.labelMedium,
    );
    final tp = TextPainter(
      text: span,
      maxLines: null,
      textDirection: TextDirection.ltr,
    );
    tp.layout(
        maxWidth: MediaQuery.of(context).size.width - 30); // عرض TextField

    // محاسبه تعداد خطوط
    int lines = (tp.size.height / tp.preferredLineHeight).ceil();

    // اگر تعداد خطوط تغییر کرد، height را تنظیم کن
    if (lines != descriptionLines) {
      setState(() {
        descriptionLines = lines;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return BlocBuilder<NoteBloc, NoteState>(builder: (context, state) {
      if (state is NoteSaving) {
        return const CircularIndicatorWidget();
      }
      if (state is NoteInitial) {
        // تغییر رنگ متن
        Color initialColor = state.note.noteBackground!.darkColor! ==
                Colors.transparent
            ? Theme.of(context).scaffoldBackgroundColor
            : BackgroundChanger()
                .colorBackGroundChanger(state.note.noteBackground!, context)!;
        String? initialBG = BackgroundChanger()
            .imageBackGroundChanger(state.note.noteBackground!, context);

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
                          selectedNote: widget.editMode ?? false),
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
                                      style: themeData.textTheme.labelMedium,
                                      maxLines: null,
                                      minLines: 1,
                                      keyboardType: TextInputType.multiline,
                                      decoration: InputDecoration(
                                        hintText: "Title",
                                        hintStyle:
                                            themeData.textTheme.labelMedium,
                                        disabledBorder: InputBorder.none,
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ).animate().fade(
                                      duration:
                                          const Duration(milliseconds: 300)),
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    height: descriptionLines * 24.0 +
                                        16.0, // ارتفاع متغیر
                                    child: TextField(
                                      controller: descriptionController,
                                      scrollPhysics:
                                          const NeverScrollableScrollPhysics(),
                                      maxLines: null,
                                      minLines: 1,
                                      keyboardType: TextInputType.multiline,
                                      style: themeData.textTheme.labelMedium,
                                      decoration: InputDecoration(
                                        hintText: "Description",
                                        hintStyle:
                                            themeData.textTheme.labelMedium,
                                        disabledBorder: InputBorder.none,
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ).animate().fade(
                                      duration:
                                          const Duration(milliseconds: 300)),
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
                                                        vertical: 8),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white30,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                          label.labelName,
                                                          style: themeData
                                                              .textTheme
                                                              .labelSmall),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ).animate().fade(
                                          duration:
                                              const Duration(milliseconds: 300))
                                      : const SizedBox.shrink(),
                                  initialColor != Colors.transparent &&
                                          initialColor !=
                                              NoteConstants
                                                  .noteColors[0].lightColor &&
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
                                        ).animate().fade(
                                          duration:
                                              const Duration(milliseconds: 300))
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
