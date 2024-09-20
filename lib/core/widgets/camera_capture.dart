import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraCapture {
  /// this method opens camera and take image and convert to Uint8List so we can save to hive
  static Future<Uint8List?> openCamera(
      BuildContext context, ImageSource imageSource) async {
    final ImagePicker picker = ImagePicker();
    XFile? pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      List<int> imageBytes = await pickedFile.readAsBytes();
      return Uint8List.fromList(imageBytes);
    }
    return null;
  }
}
