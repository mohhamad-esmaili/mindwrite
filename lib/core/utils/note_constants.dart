import 'package:flutter/material.dart';
import 'package:mindwrite/core/gen/assets.gen.dart';
import 'package:mindwrite/features/shared_bloc/data/model/background_model.dart';

class NoteConstants {
  static List<BackgroundModel> noteColors = [
    BackgroundModel(
      darkColor: Colors.transparent,
      lightColor: const Color.fromRGBO(244, 247, 252, 1),
    ),
    BackgroundModel(
      darkColor: const Color.fromRGBO(105, 42, 24, 1),
      lightColor: const Color.fromRGBO(250, 175, 169, 1),
    ),
    BackgroundModel(
      darkColor: const Color.fromRGBO(124, 74, 3, 1),
      lightColor: const Color.fromRGBO(242, 159, 117, 1),
    ),
    BackgroundModel(
      darkColor: const Color.fromRGBO(38, 77, 59, 1),
      lightColor: const Color.fromRGBO(255, 248, 185, 1),
    ),
    BackgroundModel(
      darkColor: const Color.fromRGBO(12, 99, 93, 1),
      lightColor: const Color.fromRGBO(226, 246, 211, 1),
    ),
    BackgroundModel(
      darkColor: const Color.fromRGBO(37, 100, 118, 1),
      lightColor: const Color.fromRGBO(180, 222, 212, 1),
    ),
    BackgroundModel(
      darkColor: const Color.fromRGBO(39, 66, 85, 1),
      lightColor: const Color.fromRGBO(211, 228, 236, 1),
    ),
    BackgroundModel(
      darkColor: const Color.fromRGBO(72, 46, 91, 1),
      lightColor: const Color.fromRGBO(175, 204, 220, 1),
    ),
    BackgroundModel(
      darkColor: const Color.fromRGBO(109, 57, 79, 1),
      lightColor: const Color.fromRGBO(211, 191, 219, 1),
    ),
    BackgroundModel(
      darkColor: const Color.fromRGBO(75, 68, 58, 1),
      lightColor: const Color.fromRGBO(245, 226, 220, 1),
    ),
    BackgroundModel(
      darkColor: const Color.fromRGBO(35, 36, 40, 1),
      lightColor: const Color.fromRGBO(233, 227, 211, 1),
    ),
  ];

  static List<BackgroundModel> noteBackgrounds = [
    BackgroundModel(
      darkBackgroundPath: null,
      lightBackgroundPath: null,
    ),
    BackgroundModel(
      darkBackgroundPath: Assets.images.fruitNight.path,
      lightBackgroundPath: Assets.images.fruitLight.path,
    ),
    BackgroundModel(
      darkBackgroundPath: Assets.images.foodNight.path,
      lightBackgroundPath: Assets.images.foodLight.path,
    ),
    BackgroundModel(
      darkBackgroundPath: Assets.images.poolNight.path,
      lightBackgroundPath: Assets.images.poolLight.path,
    ),
    BackgroundModel(
      darkBackgroundPath: Assets.images.tranNight.path,
      lightBackgroundPath: Assets.images.tranLight.path,
    ),
    BackgroundModel(
      darkBackgroundPath: Assets.images.parkNight.path,
      lightBackgroundPath: Assets.images.parkLight.path,
    ),
    BackgroundModel(
      darkBackgroundPath: Assets.images.book.path,
      lightBackgroundPath: Assets.images.book.path,
    ),
    BackgroundModel(
      darkBackgroundPath: Assets.images.music.path,
      lightBackgroundPath: Assets.images.music.path,
    ),
    BackgroundModel(
      darkBackgroundPath: Assets.images.pencill.path,
      lightBackgroundPath: Assets.images.pencill.path,
    ),
  ];
}
