import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';
part 'label_model.g.dart';

@HiveType(typeId: 3)
class LabelModel {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final DateTime? createdDate;
  @HiveField(2)
  final String labelName;

  static const Uuid _uuid = Uuid();

  LabelModel({String? id, DateTime? createdDate, required this.labelName})
      : id = id ?? _uuid.v4(),
        createdDate = createdDate ?? DateTime.now();
}
