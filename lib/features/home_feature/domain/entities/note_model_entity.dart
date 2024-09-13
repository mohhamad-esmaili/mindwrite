import 'package:equatable/equatable.dart';
import 'package:mindwrite/features/home_feature/data/model/background_model.dart';
import 'package:mindwrite/features/home_feature/data/model/label_model.dart';

class NoteModelEntity extends Equatable {
  final String? id;
  final String? title;
  final String? description;
  final DateTime? lastUpdate;
  final List<LabelModel>? labels;
  final BackgroundModel? noteBackground;
  final bool? pin;
  final bool? archived;

  const NoteModelEntity(
      {required this.id,
      required this.title,
      required this.description,
      this.lastUpdate,
      this.labels,
      this.noteBackground,
      this.pin = false,
      this.archived = false});

  @override
  List<Object?> get props =>
      [id, title, description, labels, noteBackground, pin, archived];
}
