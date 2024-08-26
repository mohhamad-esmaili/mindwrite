import 'package:equatable/equatable.dart';
import 'package:mindwrite/features/data/models/background_model.dart';
import 'package:mindwrite/features/data/models/label_model.dart';

class NoteModelEntity extends Equatable {
  final String title;
  final String description;
  final DateTime? lastUpdate;
  final List<LabelModel>? labels;
  final BackgroundModel? noteBackground;

  const NoteModelEntity(
      {required this.title,
      required this.description,
      this.lastUpdate,
      this.labels,
      this.noteBackground});

  @override
  List<Object?> get props => [title, description, labels, noteBackground];
}
