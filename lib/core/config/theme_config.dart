import 'package:flutter/material.dart';
import 'package:mindwrite/core/utils/color_constants.dart';

class ThemeConfig {
  static final darkAppTheme = ThemeData(
    fontFamily: 'Roboto',
    primaryColor: ColorConstants.primaryColor,
    scaffoldBackgroundColor: ColorConstants.scaffoldDarkColor,
    appBarTheme: AppBarTheme(
      backgroundColor: ColorConstants.scaffoldDarkColor,
      toolbarHeight: 50,
      titleTextStyle: TextStyle(
        fontSize: 20,
        color: ColorConstants.whiteTextColor,
      ),
      iconTheme: IconThemeData(
        color: ColorConstants.whiteTextColor,
      ),
    ),
    iconTheme: IconThemeData(color: ColorConstants.primaryDarkColor),
    drawerTheme: DrawerThemeData(
      backgroundColor: ColorConstants.scaffoldDarkColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(0),
          bottomRight: Radius.circular(0),
        ),
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: ColorConstants.snackBarWhitecolor,
      contentTextStyle: TextStyle(
        color: ColorConstants.blackTextColor,
        fontSize: 16,
      ),
      actionTextColor: ColorConstants.secondaryColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      behavior: SnackBarBehavior.floating,
    ),
  );
}
