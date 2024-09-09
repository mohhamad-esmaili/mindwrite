import 'package:hive_flutter/hive_flutter.dart';
import 'package:mindwrite/features/data/models/background_model.dart';
import 'package:mindwrite/features/data/models/label_model.dart';
import 'package:mindwrite/features/domain/entities/note_model_entity.dart';

part 'note_model.g.dart';

@HiveType(typeId: 1)
class NoteModel extends NoteModelEntity {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final String? title;
  @HiveField(2)
  final String? description;
  @HiveField(3)
  final DateTime lastUpdate;
  @HiveField(4)
  final List<LabelModel>? labels;
  @HiveField(5)
  final BackgroundModel? noteBackground;
  @HiveField(6)
  final bool pin;

  const NoteModel({
    required this.id,
    required this.title,
    required this.description,
    required this.lastUpdate,
    this.labels,
    this.noteBackground,
    this.pin = false,
  }) : super(
            id: id,
            title: title,
            description: description,
            labels: labels,
            lastUpdate: lastUpdate,
            noteBackground: noteBackground,
            pin: pin);

  factory NoteModel.fromJson(dynamic json) {
    return NoteModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      lastUpdate: json['lastupdate'] ?? DateTime.now(),
      labels: json['labels'] ?? [],
      noteBackground: json['noteBackground'] ?? [],
      pin: json['pin'] ?? false,
    );
  }

  NoteModel copyWith({
    int? id,
    String? title,
    String? description,
    DateTime? lastUpdate,
    List<LabelModel>? labels,
    BackgroundModel? noteBackground,
    bool? pin,
  }) {
    return NoteModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      lastUpdate: lastUpdate ?? this.lastUpdate,
      labels: labels ?? this.labels,
      noteBackground: noteBackground ?? this.noteBackground,
      pin: pin ?? this.pin,
    );
  }
}
