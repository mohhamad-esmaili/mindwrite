import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:mindwrite/features/shared_bloc/data/model/background_model.dart';
import 'package:mindwrite/features/label_feature/data/model/label_model.dart';

class NoteModelEntity extends Equatable {
  final String? id;
  final String? title;
  final String? description;
  final DateTime? lastUpdate;
  final List<LabelModel>? labels;
  final BackgroundModel? noteBackground;
  final bool? pin;
  final bool? archived;
  final List<Uint8List>? drawingsList;
  final bool? isDeleted;

  const NoteModelEntity({
    required this.id,
    required this.title,
    required this.description,
    this.lastUpdate,
    this.labels,
    this.noteBackground,
    this.pin = false,
    this.archived = false,
    this.drawingsList,
    this.isDeleted = false,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        labels,
        noteBackground,
        pin,
        archived,
        drawingsList,
        isDeleted
      ];
}
