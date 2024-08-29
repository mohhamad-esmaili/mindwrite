import 'package:flutter/material.dart';
import 'package:mindwrite/core/utils/color_constants.dart';

class ThemeConfig {
  static final darkAppTheme = ThemeData(
    fontFamily: 'Roboto',
    primaryColor: ColorConstants.primaryDarkColor,
    scaffoldBackgroundColor: ColorConstants.scaffoldDarkColor,
    appBarTheme: AppBarTheme(backgroundColor: ColorConstants.scaffoldDarkColor),
    iconTheme: IconThemeData(color: ColorConstants.primaryDarkColor),
  );
}
