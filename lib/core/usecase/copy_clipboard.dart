import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mindwrite/core/localization/app_localizations.dart';
import 'package:mindwrite/core/widgets/snackbar_widget.dart'; // For Clipboard functionality

class CopyClipboardService {
  static void copyNoteToClipboard(
      String title, String? description, BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    // Step 1: Format the note into a string
    String noteCopy = '''
  ${appLocalizations.title}: $title
  
  ${description ?? ''}
  ''';

    Clipboard.setData(ClipboardData(text: noteCopy)).then((_) {
      if (context.mounted) {
        SnackbarService.showStatusSnackbar(
            message: appLocalizations.noteCopied, context: context);
      }
    });
  }
}
