import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mindwrite/features/shared_bloc/data/model/background_model.dart';
import 'package:mindwrite/features/shared_bloc/presentation/bloc/shared_bloc.dart';

class BackgroundChanger {
  Color? colorBackGroundChanger(
      BackgroundModel noteBackGround, BuildContext context) {
    SharedBloc sharedBloc = context.read<SharedBloc>();
    bool isDarkMode = sharedBloc.themeMode == ThemeMode.dark;

    if (isDarkMode) {
      return noteBackGround.darkColor;
    } else {
      return noteBackGround.lightColor;
    }
  }

  String? imageBackGroundChanger(
      BackgroundModel noteBackGround, BuildContext context) {
    SharedBloc sharedBloc = context.read<SharedBloc>();
    bool isDarkMode = sharedBloc.themeMode == ThemeMode.dark;

    if (isDarkMode) {
      return noteBackGround.darkBackgroundPath;
    } else {
      return noteBackGround.lightBackgroundPath;
    }
  }
}
