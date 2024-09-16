import 'package:flutter/material.dart';

class SnackbarService {
  Future<void> show({
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
