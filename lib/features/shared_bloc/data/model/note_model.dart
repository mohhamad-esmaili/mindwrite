import 'package:hive_flutter/hive_flutter.dart';
import 'package:mindwrite/features/shared_bloc/data/model/background_model.dart';
import 'package:mindwrite/features/label_feature/data/model/label_model.dart';
import 'package:mindwrite/features/shared_bloc/domain/entities/note_model_entity.dart';
import 'package:uuid/uuid.dart';
import 'dart:typed_data';

part 'note_model.g.dart';

@HiveType(typeId: 1)
class NoteModel extends NoteModelEntity {
  @override
  @HiveField(0)
  final String? id;
  @override
  @HiveField(1)
  final String? title;
  @override
  @HiveField(2)
  final String? description;
  @override
  @HiveField(3)
  final DateTime lastUpdate;
  @override
  @HiveField(4)
  final List<LabelModel>? labels;
  @override
  @HiveField(5)
  final BackgroundModel? noteBackground;
  @override
  @HiveField(6)
  final bool pin;
  @override
  @HiveField(7)
  late final bool archived;
  @override
  @HiveField(9)
  final List<Uint8List>? drawingsList;
  @override
  @HiveField(10)
  late final bool? isDeleted;

  static const Uuid _uuid = Uuid();

  NoteModel({
    super.id,
    required this.title,
    required this.description,
    required this.lastUpdate,
    this.labels = const [],
    this.noteBackground,
    this.pin = false,
    this.archived = false,
    this.drawingsList,
    this.isDeleted = false,
  })  : id = id ?? _uuid.v4(),
        super(
            title: title,
            description: description,
            labels: labels,
            lastUpdate: lastUpdate,
            noteBackground: noteBackground,
            pin: pin,
            archived: archived,
            drawingsList: drawingsList,
            isDeleted: isDeleted);

  factory NoteModel.fromJson(dynamic json) {
    return NoteModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      lastUpdate: json['lastupdate'] ?? DateTime.now(),
      labels: json['labels'] ?? [],
      noteBackground: json['noteBackground'] ?? [],
      pin: json['pin'] ?? false,
      archived: json['archived'] ?? false,
      drawingsList: json['drawingList'],
      isDeleted: json['isDeleted'],
    );
  }

  NoteModel copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? lastUpdate,
    List<LabelModel>? labels,
    BackgroundModel? noteBackground,
    bool? pin,
    bool? archived,
    List<Uint8List>? drawingsList,
    bool? isDeleted,
  }) {
    return NoteModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      lastUpdate: lastUpdate ?? this.lastUpdate,
      labels: labels ?? this.labels,
      noteBackground: noteBackground ?? this.noteBackground,
      pin: pin ?? this.pin,
      archived: archived ?? this.archived,
      drawingsList: drawingsList ?? this.drawingsList,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }
}
