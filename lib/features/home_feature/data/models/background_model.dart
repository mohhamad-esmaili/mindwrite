import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'background_model.g.dart';

@HiveType(typeId: 2)
class BackgroundModel {
  @HiveField(0)
  Color color;
  BackgroundModel({this.color = Colors.transparent});
}
