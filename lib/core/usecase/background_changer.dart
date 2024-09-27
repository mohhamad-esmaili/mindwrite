import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindwrite/core/utils/note_constants.dart';
import 'package:mindwrite/features/shared_bloc/data/model/background_model.dart';
import 'package:mindwrite/features/shared_bloc/presentation/bloc/shared_bloc.dart';

class BackgroundChanger {
  final List<BackgroundModel> _darkColors = NoteConstants.noteDarkColors;
  final List<BackgroundModel> _lightColors = NoteConstants.noteLightColors;

  final List<BackgroundModel> _darkImages = NoteConstants.noteDarkBackgrounds;
  final List<BackgroundModel> _lightImages = NoteConstants.noteLightBackgrounds;

  Color? colorBackGroundChanger(
      BackgroundModel noteBackGround, BuildContext context) {
    SharedBloc sharedBloc = context.read<SharedBloc>();
    bool isDarkMode = sharedBloc.themeMode == ThemeMode.light ? false : true;

    int colorIndex = NoteConstants.noteDarkColors.indexWhere(
      (element) => element.color == noteBackGround.color,
    );

    switch (colorIndex) {
      case 0:
        return isDarkMode ? _darkColors[0].color : _lightColors[0].color;
      case 1:
        return isDarkMode ? _darkColors[1].color : _lightColors[1].color;
      case 2:
        return isDarkMode ? _darkColors[2].color : _lightColors[2].color;
      case 3:
        return isDarkMode ? _darkColors[3].color : _lightColors[3].color;
      case 4:
        return isDarkMode ? _darkColors[4].color : _lightColors[4].color;
      case 5:
        return isDarkMode ? _darkColors[5].color : _lightColors[5].color;
      case 6:
        return isDarkMode ? _darkColors[6].color : _lightColors[6].color;
      case 7:
        return isDarkMode ? _darkColors[7].color : _lightColors[7].color;
      case 8:
        return isDarkMode ? _darkColors[8].color : _lightColors[8].color;
      case 9:
        return isDarkMode ? _darkColors[9].color : _lightColors[9].color;
      case 10:
        return isDarkMode ? _darkColors[10].color : _lightColors[10].color;

      default:
        return isDarkMode ? _darkColors[0].color : _lightColors[0].color;
    }
  }
}
