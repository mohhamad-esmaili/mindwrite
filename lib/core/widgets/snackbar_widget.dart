import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mindwrite/core/usecase/background_changer.dart';
import 'package:mindwrite/core/utils/note_constants.dart';
import 'package:mindwrite/features/shared_bloc/data/model/background_model.dart';
import 'package:mindwrite/features/shared_bloc/presentation/bloc/shared_bloc.dart';

class SnackbarService {
  static Future<void> showAskingDialog({
    required BuildContext context,
    required String questionText,
    required VoidCallback onYesPress,
    required String onYesBTNText,
  }) async {
    ThemeData themeData = Theme.of(context);
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          questionText,
          textAlign: TextAlign.center,
          style: themeData.textTheme.labelMedium,
        ),
        backgroundColor: themeData.scaffoldBackgroundColor,
        actionsAlignment: MainAxisAlignment.spaceAround,
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              shadowColor: themeData.primaryColor,
            ),
            child: Text(
              "No",
              style: themeData.textTheme.labelMedium,
            ),
          ),
          TextButton(
            onPressed: () => onYesPress(),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              shadowColor: themeData.primaryColor,
            ),
            child: Text(
              onYesBTNText,
              style: themeData.textTheme.labelMedium,
            ),
          ),
        ],
      ),
    );
  }

  static Future<void> showPaletteSelector({
    required BuildContext context,
  }) async {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          "Note Color",
          style: Theme.of(context).textTheme.labelLarge,
        ),
        actionsAlignment: MainAxisAlignment.spaceAround,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        actions: [
          SizedBox(
            width: 200,
            height: 200,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
              ),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: NoteConstants.noteColors.length,
              itemBuilder: (BuildContext context, int index) {
                BackgroundModel selectedColor = NoteConstants.noteColors[index];

                return InkWell(
                  onTap: () {
                    BlocProvider.of<SharedBloc>(context).add(
                      ChangePaletteNoteEvent(
                        selectedColor.lightColor!,
                        selectedColor.darkColor!,
                      ),
                    );
                    context.pop();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white24, width: 1),
                      color: BackgroundChanger()
                          .colorBackGroundChanger(selectedColor, context),
                    ),
                    child: index == 0
                        ? Icon(
                            Icons.invert_colors_off_rounded,
                            color: Theme.of(context).iconTheme.color,
                          )
                        : null,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  static Future<void> showStatusSnackbar({
    required String message,
    required BuildContext context,
    String actionLabel = '',
    VoidCallback? onAction,
    VoidCallback? onClosed,
  }) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    scaffoldMessenger.removeCurrentSnackBar();
    await scaffoldMessenger
        .showSnackBar(
          SnackBar(
            content: Text(
              message,
              style: Theme.of(context).textTheme.labelSmall,
            ),
            duration: const Duration(seconds: 1),
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            action: actionLabel.isNotEmpty
                ? SnackBarAction(
                    label: actionLabel,
                    onPressed: () {
                      if (onAction != null) onAction();
                    },
                  )
                : null,
          ),
        )
        .closed
        .then((_) {
      if (onClosed != null) onClosed();
    });
  }
}
