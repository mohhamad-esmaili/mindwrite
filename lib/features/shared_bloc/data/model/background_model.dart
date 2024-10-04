import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'background_model.g.dart';

@HiveType(typeId: 2)
class BackgroundModel {
  @HiveField(0)
  Color? lightColor;
  @HiveField(1)
  Color? darkColor;
  @HiveField(2)
  String? lightBackgroundPath;
  @HiveField(3)
  String? darkBackgroundPath;

  BackgroundModel({
    this.lightColor = Colors.transparent,
    this.darkColor = Colors.transparent,
    this.lightBackgroundPath,
    this.darkBackgroundPath,
  });

  BackgroundModel copyWith({
    Color? lightColor,
    Color? darkColor,
    String? lightBackgroundPath,
    String? darkBackgroundPath,
  }) {
    return BackgroundModel(
      lightColor: lightColor ?? this.lightColor,
      darkColor: darkColor ?? this.darkColor,
      lightBackgroundPath: lightBackgroundPath ?? this.lightBackgroundPath,
      darkBackgroundPath: darkBackgroundPath ?? this.darkBackgroundPath,
    );
  }
}
