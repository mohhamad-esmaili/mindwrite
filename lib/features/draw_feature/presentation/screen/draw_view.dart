import 'dart:ui';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mindwrite/core/resources/note_arguments.dart';
import 'package:mindwrite/core/widgets/snackbar_widget.dart';

import 'package:mindwrite/features/note_feature/presentation/bloc/note_bloc.dart';
import 'package:mindwrite/features/shared_bloc/data/model/note_model.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

class DrawView extends StatelessWidget {
  final NoteModel? selctedNote;
  DrawView({super.key, this.selctedNote});

  final GlobalKey<SfSignaturePadState> _signaturePadKey = GlobalKey();

  Future<Uint8List?> captureSignature() async {
    try {
      final signaturePad = _signaturePadKey.currentState;
      if (signaturePad != null) {
        final image = await signaturePad.toImage();
        final byteData = await image.toByteData(format: ImageByteFormat.png);
        if (byteData != null) {
          return byteData.buffer.asUint8List();
        }
      }
    } catch (e) {
      debugPrint("Error capturing signature: $e");
    }
    return null;
  }

  Future<bool> isDrawingEmpty(Uint8List? imageBytes) async {
    if (imageBytes == null || imageBytes.isEmpty) return true;

    // Decode the image to check its contents
    final image = await decodeImageFromList(imageBytes);
    final byteData = await image.toByteData(format: ImageByteFormat.rawRgba);
    if (byteData == null) return true;

    // Check for non-white pixels in a more efficient way
    final int length = byteData.lengthInBytes;
    for (int i = 0; i < length; i += 4) {
      final r = byteData.getUint8(i);
      final g = byteData.getUint8(i + 1);
      final b = byteData.getUint8(i + 2);
      final a = byteData.getUint8(i + 3);

      // Consider a tolerance range if exact white is not reliable
      if (a > 0 && (r < 250 || g < 250 || b < 250)) {
        return false; // Drawing exists
      }
    }

    return true; // All pixels are considered white or fully transparent
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Disable back button by returning false
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () async {
              final imageBytes = await captureSignature();

              final isEmpty = await isDrawingEmpty(imageBytes);

              if (!isEmpty) {
                if (context.mounted && imageBytes != null) {
                  context.read<NoteBloc>().add(ChangeDrawingLists(imageBytes));
                }
              } else if (context.mounted) {
                SnackbarService.showStatusSnackbar(
                    message: 'No drawing detected', context: context);
              }

              if (context.mounted) {
                _signaturePadKey.currentState!.clear();

                context.go('/create_note',
                    extra: NoteArguments(
                        selectedNote: context.read<NoteBloc>().note,
                        editMode: true));
              }
            },
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
          actions: [
            IconButton(
                onPressed: () => _signaturePadKey.currentState!.clear(),
                icon: Icon(
                  Icons.refresh_rounded,
                  color: Theme.of(context).iconTheme.color,
                ))
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SfSignaturePad(
                  key: _signaturePadKey,
                  minimumStrokeWidth: 1,
                  maximumStrokeWidth: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
