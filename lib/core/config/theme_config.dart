import 'package:flutter/material.dart';
import 'package:mindwrite/core/utils/color_constants.dart';

class ThemeConfig {
  static final darkAppTheme = ThemeData(
      fontFamily: 'Roboto',
      primaryColor: ColorConstants.primaryColor,
      scaffoldBackgroundColor: ColorConstants.scaffoldDarkColor,
      appBarTheme:
          AppBarTheme(backgroundColor: ColorConstants.scaffoldDarkColor),
      iconTheme: IconThemeData(color: ColorConstants.primaryDarkColor),
      drawerTheme: DrawerThemeData(
        backgroundColor: ColorConstants.scaffoldDarkColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(0),
            bottomRight: Radius.circular(0),
          ),
        ),
      ));
}
