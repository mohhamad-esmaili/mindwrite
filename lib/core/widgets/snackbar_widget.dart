import 'package:flutter/material.dart';

class SnackbarWidget {
  static void getSnackbar(BuildContext context, String snackBarMessage,
      String onpressLabel, VoidCallback? onPress, VoidCallback? onClosed) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    scaffoldMessenger.hideCurrentSnackBar();
    scaffoldMessenger
        .showSnackBar(
          SnackBar(
            content: Text(snackBarMessage),
            duration: const Duration(seconds: 2),
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            action: SnackBarAction(
              label: onpressLabel,
              onPressed: () {
                onPress != null ? onPress() : null;
              },
            ),
          ),
        )
        .closed
        .then((_) {
      onClosed != null ? onClosed() : null;
    });
  }
}
