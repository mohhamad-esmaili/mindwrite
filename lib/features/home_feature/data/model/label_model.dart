import 'package:hive_flutter/hive_flutter.dart';

part 'label_model.g.dart';

@HiveType(typeId: 3)
class LabelModel {
  @HiveField(0)
  final String labelName;
  LabelModel({required this.labelName});
}
