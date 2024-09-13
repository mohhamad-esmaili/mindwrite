import 'package:equatable/equatable.dart';
import 'package:mindwrite/features/home_feature/data/model/note_model.dart';

abstract class ArchiveEvent extends Equatable {
  const ArchiveEvent();
  @override
  List<Object> get props => [];
}

class GetAllArchive extends ArchiveEvent {
  const GetAllArchive();

  @override
  List<Object> get props => [];
}

class ToggleOffArchiveEvent extends ArchiveEvent {
  final NoteModel note;
  const ToggleOffArchiveEvent(this.note);
  @override
  List<Object> get props => [note];
}
