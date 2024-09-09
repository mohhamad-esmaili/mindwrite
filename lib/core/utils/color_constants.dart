import 'package:flutter/material.dart';
import 'package:mindwrite/features/home_feature/data/models/background_model.dart';

class ColorConstants {
  static List<BackgroundModel> noteColors = [
    BackgroundModel(color: Colors.grey[800]!),
    BackgroundModel(color: const Color.fromRGBO(105, 42, 24, 1)),
    BackgroundModel(color: const Color.fromRGBO(124, 74, 3, 1)),
    BackgroundModel(color: const Color.fromRGBO(38, 77, 59, 1)),
    BackgroundModel(color: const Color.fromRGBO(12, 99, 93, 1)),
    BackgroundModel(color: const Color.fromRGBO(37, 100, 118, 1)),
    BackgroundModel(color: const Color.fromRGBO(39, 66, 85, 1)),
    BackgroundModel(color: const Color.fromRGBO(72, 46, 91, 1)),
    BackgroundModel(color: const Color.fromRGBO(109, 57, 79, 1)),
    BackgroundModel(color: const Color.fromRGBO(75, 68, 58, 1)),
    BackgroundModel(color: const Color.fromRGBO(35, 36, 40, 1)),
  ];
  static Color scaffoldDarkColor = const Color.fromRGBO(19, 19, 19, 1);
  static Color appbarDarkColor = const Color.fromRGBO(30, 31, 33, 1);
  static Color primaryDarkColor = const Color.fromRGBO(197, 198, 2020, 1);
  static Color primaryColor = const Color.fromRGBO(0, 74, 119, 1);

  static Color WhiteTextColor = const Color.fromRGBO(255, 255, 255, 1);
  static Color DarkerWhiteTextColor = const Color.fromRGBO(200, 200, 200, 1);
}
