import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'background_model.g.dart';

@HiveType(typeId: 2)
class BackgroundModel {
  @HiveField(0)
  Color color;
  @HiveField(1)
  String? backgroundPath;
  BackgroundModel({this.color = Colors.transparent, this.backgroundPath});

  BackgroundModel copyWith({
    Color? color,
    String? backgroundPath,
    required BackgroundModel noteBackground,
  }) {
    return BackgroundModel(
      color: color ?? this.color,
      backgroundPath: backgroundPath ?? this.backgroundPath,
    );
  }
}
