import 'package:flutter/material.dart';
import 'package:mindwrite/core/gen/assets.gen.dart';
import 'package:mindwrite/features/shared_bloc/data/model/background_model.dart';

class NoteConstants {
  static List<BackgroundModel> noteDarkColors = [
    BackgroundModel(color: Colors.transparent),
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
  static List<BackgroundModel> noteLightColors = [
    BackgroundModel(color: const Color.fromRGBO(244, 247, 252, 1)),
    BackgroundModel(color: const Color.fromRGBO(250, 175, 169, 1)),
    BackgroundModel(color: const Color.fromRGBO(242, 159, 117, 1)),
    BackgroundModel(color: const Color.fromRGBO(255, 248, 185, 1)),
    BackgroundModel(color: const Color.fromRGBO(226, 246, 211, 1)),
    BackgroundModel(color: const Color.fromRGBO(180, 222, 212, 1)),
    BackgroundModel(color: const Color.fromRGBO(211, 228, 236, 1)),
    BackgroundModel(color: const Color.fromRGBO(175, 204, 220, 1)),
    BackgroundModel(color: const Color.fromRGBO(211, 191, 219, 1)),
    BackgroundModel(color: const Color.fromRGBO(245, 226, 220, 1)),
    BackgroundModel(color: const Color.fromRGBO(233, 227, 211, 1)),
  ];
  static List<BackgroundModel> noteDarkBackgrounds = [
    BackgroundModel(backgroundPath: null),
    BackgroundModel(backgroundPath: Assets.images.fruitNight.path),
    BackgroundModel(backgroundPath: Assets.images.foodNight.path),
    BackgroundModel(backgroundPath: Assets.images.poolNight.path),
    BackgroundModel(backgroundPath: Assets.images.tranNight.path),
    BackgroundModel(backgroundPath: Assets.images.parkNight.path),
    BackgroundModel(backgroundPath: Assets.images.book.path),
    BackgroundModel(backgroundPath: Assets.images.music.path),
    BackgroundModel(backgroundPath: Assets.images.pencill.path),
  ];
  static List<BackgroundModel> noteLightBackgrounds = [
    BackgroundModel(backgroundPath: null),
    BackgroundModel(backgroundPath: Assets.images.foodLight.path),
    BackgroundModel(backgroundPath: Assets.images.fruitLight.path),
    BackgroundModel(backgroundPath: Assets.images.poolLight.path),
    BackgroundModel(backgroundPath: Assets.images.tranLight.path),
    BackgroundModel(backgroundPath: Assets.images.parkLight.path),
    BackgroundModel(backgroundPath: Assets.images.book.path),
    BackgroundModel(backgroundPath: Assets.images.music.path),
    BackgroundModel(backgroundPath: Assets.images.pencill.path),
  ];
}
