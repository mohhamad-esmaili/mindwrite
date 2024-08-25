import 'package:hive_flutter/hive_flutter.dart';
import 'package:mindwrite/features/domain/entities/note_model_entity.dart';

part 'note_model.g.dart';

@HiveType(typeId: 1)
class NoteModel extends NoteModelEntity {
  const NoteModel({
    @HiveField(0) required super.title,
    @HiveField(1) required super.description,
    @HiveField(2) super.labels,
    @HiveField(3) super.noteBackground,
  });

  factory NoteModel.fromJson(dynamic json) {
    return NoteModel(
      title: json['title'],
      description: json['description'],
      labels: json['labels'] ?? [],
      noteBackground: json['noteBackground'] ?? [],
    );
  }
}
