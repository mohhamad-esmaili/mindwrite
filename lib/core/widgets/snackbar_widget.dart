import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SnackbarService {
  static Future<void> showAskingDialog({
    required BuildContext context,
    required String questionText,
    required VoidCallback onYesPress,
    required String onYesBTNText,
  }) async {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          questionText,
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.spaceAround,
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              shadowColor: Theme.of(context).primaryColor,
            ),
            child: const Text("No"),
          ),
          TextButton(
            onPressed: () => onYesPress(),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              shadowColor: Theme.of(context).primaryColor,
            ),
            child: Text(onYesBTNText),
          ),
        ],
      ),
    );
  }

  Future<void> showStatusSnackbar({
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
            content: Text(message),
            duration: const Duration(seconds: 2),
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
