import 'package:flutter/material.dart';
import 'package:mindwrite/core/widgets/snackbar_widget.dart';
import 'package:mindwrite/features/shared_bloc/data/model/note_model.dart';
import 'package:share_plus/share_plus.dart';

class ShareService {
  static void sendTo(NoteModel note, BuildContext context) {
    if (note.drawingsList != null && note.drawingsList!.isNotEmpty) {
      List<XFile> imageList =
          note.drawingsList!.map((item) => XFile.fromData(item)).toList();

      if (imageList.isNotEmpty) {
        Share.shareXFiles(
          imageList,
          text: note.title ?? '',
          subject: note.description ?? '',
        );
      }
    } else if (note.title!.isNotEmpty) {
      Share.share(note.title!, subject: note.description);
    } else {
      SnackbarService.showStatusSnackbar(
          message: "Enter Title", context: context);
    }
  }
}
