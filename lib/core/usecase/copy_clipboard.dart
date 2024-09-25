import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mindwrite/core/widgets/snackbar_widget.dart'; // For Clipboard functionality

class CopyClipboardService {
  static void copyNoteToClipboard(
      String title, String? description, BuildContext context) {
    // Step 1: Format the note into a string
    String noteCopy = '''
  Title: $title
  
  ${description ?? ''}
  ''';

    Clipboard.setData(ClipboardData(text: noteCopy)).then((_) {
      if (context.mounted) {
        SnackbarService.showStatusSnackbar(
            message: "Note copied", context: context);
      }
    });
  }
}
