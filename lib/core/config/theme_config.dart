import 'package:flutter/material.dart';
import 'package:mindwrite/core/gen/fonts.gen.dart';
import 'package:mindwrite/core/utils/color_constants.dart';

class ThemeConfig {
  // تم لایت با توجه به زبان
  static ThemeData lightTheme(String locale) {
    String fontFamily =
        locale == 'fa' ? FontFamily.samim : FontFamily.googleSans;
    return ThemeData(
      fontFamily: fontFamily,
      primaryColor: AppColorConstants.primaryColor,
      scaffoldBackgroundColor: AppColorConstants.scaffoldLightColor,
      textTheme: TextTheme(
        labelLarge:
            TextStyle(fontSize: 20, color: AppColorConstants.blackTextColor),
        labelMedium:
            TextStyle(fontSize: 15, color: AppColorConstants.blackTextColor),
        labelSmall:
            TextStyle(fontSize: 13, color: AppColorConstants.blackTextColor),
        titleMedium:
            TextStyle(fontSize: 15, color: AppColorConstants.blackTextColor),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColorConstants.appbarLightColor,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColorConstants.scaffoldLightColor,
        toolbarHeight: 50,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontFamily: fontFamily,
          color: AppColorConstants.blackTextColor,
        ),
        iconTheme: IconThemeData(
          color: AppColorConstants.blackTextColor,
        ),
      ),
      iconTheme: IconThemeData(color: AppColorConstants.darkIconColor),
      drawerTheme: DrawerThemeData(
        backgroundColor: AppColorConstants.scaffoldLightColor,
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

  // تم دارک با توجه به زبان
  static ThemeData darkTheme(String locale) {
    String fontFamily =
        locale == 'fa' ? FontFamily.samim : FontFamily.googleSans;
    return ThemeData(
      fontFamily: fontFamily,
      primaryColor: AppColorConstants.primaryColor,
      scaffoldBackgroundColor: AppColorConstants.scaffoldDarkColor,
      textTheme: TextTheme(
        labelLarge:
            TextStyle(fontSize: 20, color: AppColorConstants.whiteTextColor),
        labelMedium:
            TextStyle(fontSize: 15, color: AppColorConstants.whiteTextColor),
        labelSmall:
            TextStyle(fontSize: 13, color: AppColorConstants.whiteTextColor),
        titleMedium: TextStyle(
            fontSize: 15, color: AppColorConstants.darkerWhiteTextColor),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColorConstants.appbarDarkColor,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColorConstants.scaffoldDarkColor,
        toolbarHeight: 50,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontFamily: fontFamily,
          color: AppColorConstants.whiteTextColor,
        ),
        iconTheme: IconThemeData(
          color: AppColorConstants.whiteTextColor,
        ),
      ),
      iconTheme: IconThemeData(color: AppColorConstants.lightIconColor),
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
}
