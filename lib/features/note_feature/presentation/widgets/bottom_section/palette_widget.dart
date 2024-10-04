import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindwrite/core/usecase/background_changer.dart';
import 'package:mindwrite/core/utils/color_constants.dart';
import 'package:mindwrite/core/utils/note_constants.dart';
import 'package:mindwrite/features/note_feature/presentation/bloc/note_bloc.dart';
import 'package:mindwrite/features/shared_bloc/presentation/bloc/shared_bloc.dart';

/// contain color palette and background image changer
class PaletteButtonWidget extends StatelessWidget {
  const PaletteButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    bool isDarkMode =
        context.read<SharedBloc>().themeMode == ThemeMode.light ? false : true;
    return BlocBuilder<NoteBloc, NoteState>(
      builder: (context, state) {
        if (state is NoteInitial) {
          Color? initialColor = BackgroundChanger()
              .colorBackGroundChanger(state.note.noteBackground!, context);
          String? initialBG = BackgroundChanger()
              .imageBackGroundChanger(state.note.noteBackground!, context);
          return Container(
            color: initialColor == Colors.transparent
                ? themeData.appBarTheme.backgroundColor
                : initialColor,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 5),
                  child: Text(
                    "Colors",
                    style: themeData.textTheme.labelMedium,
                  ),
                ),
                Container(
                  height: 90,
                  color: initialColor,
                  child: Center(
                    child: ListView.builder(
                      itemCount: NoteConstants.noteColors.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        Color itemColor = isDarkMode
                            ? NoteConstants.noteColors[index].darkColor!
                            : NoteConstants.noteColors[index].lightColor!;
                        bool isFirstItem = index == 0;
                        return InkWell(
                          onTap: () {
                            BlocProvider.of<NoteBloc>(context)
                                .add(ChangeNoteColorEvent(
                              selectedDarkColor:
                                  NoteConstants.noteColors[index].darkColor!,
                              selectedLightColor:
                                  NoteConstants.noteColors[index].lightColor!,
                              selectedDarkBackGround:
                                  state.note.noteBackground!.darkBackgroundPath,
                              selectedLightBackGround: state
                                  .note.noteBackground!.lightBackgroundPath,
                            ));
                          },
                          child: Container(
                            width: 53,
                            margin: const EdgeInsets.only(left: 15, right: 5),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: index == 0
                                  ? Theme.of(context).scaffoldBackgroundColor
                                  : itemColor,
                              border: Border.all(
                                color: initialColor == itemColor
                                    ? AppColorConstants.noteSelectionColor
                                    : Colors.grey,
                                width: initialColor == itemColor ? 3 : 1,
                              ),
                            ),
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              transitionBuilder:
                                  (Widget child, Animation<double> animation) {
                                return ScaleTransition(
                                    scale: animation, child: child);
                              },
                              child: isFirstItem &&
                                      initialColor == Colors.transparent
                                  ? Icon(
                                      Icons.check,
                                      size: 30,
                                      key: ValueKey("check_$index"),
                                      color:
                                          AppColorConstants.noteSelectionColor,
                                    )
                                  : initialColor == itemColor
                                      ? Icon(
                                          Icons.check,
                                          size: 30,
                                          key: ValueKey("check_$index"),
                                          color: AppColorConstants
                                              .noteSelectionColor,
                                        )
                                      : isFirstItem
                                          ? Icon(
                                              Icons.invert_colors_off_rounded,
                                              size: 30,
                                              key: ValueKey("empty$index"),
                                              color: AppColorConstants
                                                  .noteSelectionColor,
                                            )
                                          : null,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, bottom: 5),
                  child: Text(
                    "Background",
                    style: themeData.textTheme.labelMedium,
                  ),
                ),
                Container(
                  height: 90,
                  color: initialColor == Colors.transparent
                      ? Colors.transparent
                      : initialColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 90,
                        child: ListView.builder(
                          itemCount: NoteConstants.noteBackgrounds.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            String? itemBackGround = isDarkMode
                                ? NoteConstants
                                    .noteBackgrounds[index].darkBackgroundPath
                                : NoteConstants
                                    .noteBackgrounds[index].lightBackgroundPath;
                            bool isFirstItem = index == 0;

                            return InkWell(
                              onTap: () {
                                BlocProvider.of<NoteBloc>(context)
                                    .add(ChangeNoteColorEvent(
                                  selectedDarkBackGround: NoteConstants
                                      .noteBackgrounds[index]
                                      .darkBackgroundPath,
                                  selectedLightBackGround: NoteConstants
                                      .noteBackgrounds[index]
                                      .lightBackgroundPath,
                                  selectedDarkColor:
                                      state.note.noteBackground!.darkColor,
                                  selectedLightColor:
                                      state.note.noteBackground!.lightColor,
                                ));
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    width: 70,
                                    margin: const EdgeInsets.only(
                                        left: 15, right: 5),
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      shape: BoxShape.circle,
                                      image: !isFirstItem &&
                                              itemBackGround != null
                                          ? DecorationImage(
                                              fit: BoxFit.cover,
                                              alignment: Alignment.center,
                                              image: AssetImage(itemBackGround),
                                            )
                                          : null,
                                      border: Border.all(
                                        color: initialBG == itemBackGround
                                            ? AppColorConstants
                                                .noteSelectionColor
                                            : Colors.grey,
                                        width:
                                            initialBG == itemBackGround ? 3 : 1,
                                      ),
                                    ),
                                    child: Center(
                                      child: isFirstItem
                                          ? const Icon(
                                              Icons
                                                  .image_not_supported_outlined,
                                              color: Colors.white,
                                            )
                                          : null,
                                    ),
                                  ),
                                  Positioned(
                                    right: 0,
                                    top: 0,
                                    child: AnimatedSwitcher(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      transitionBuilder: (Widget child,
                                          Animation<double> animation) {
                                        return ScaleTransition(
                                          scale: animation,
                                          child: child,
                                        );
                                      },
                                      child: initialBG == itemBackGround
                                          ? Container(
                                              key: const ValueKey('checkIcon'),
                                              padding: const EdgeInsets.all(2),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: AppColorConstants
                                                    .noteSelectionColor,
                                              ),
                                              child: Icon(
                                                Icons.check,
                                                color: Theme.of(context)
                                                    .scaffoldBackgroundColor,
                                              ),
                                            )
                                          : const SizedBox.shrink(),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
