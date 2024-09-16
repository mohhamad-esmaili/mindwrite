import 'package:flutter/material.dart';
import 'package:mindwrite/core/gen/fonts.gen.dart';
import 'package:mindwrite/core/utils/color_constants.dart';

class ThemeConfig {
  static final darkAppTheme = ThemeData(
    fontFamily: FontFamily.googleSans,
    primaryColor: AppColorConstants.primaryColor,
    scaffoldBackgroundColor: AppColorConstants.scaffoldDarkColor,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColorConstants.scaffoldDarkColor,
      toolbarHeight: 50,
      titleTextStyle: TextStyle(
        fontSize: 20,
        color: AppColorConstants.whiteTextColor,
      ),
      iconTheme: IconThemeData(
        color: AppColorConstants.whiteTextColor,
      ),
    ),
    iconTheme: IconThemeData(color: AppColorConstants.primaryDarkColor),
    drawerTheme: DrawerThemeData(
      backgroundColor: AppColorConstants.scaffoldDarkColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(0),
          bottomRight: Radius.circular(0),
        ),
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColorConstants.snackBarWhitecolor,
      contentTextStyle: TextStyle(
        color: AppColorConstants.blackTextColor,
        fontSize: 16,
      ),
      actionTextColor: AppColorConstants.secondaryColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      behavior: SnackBarBehavior.floating,
    ),
  );
}
