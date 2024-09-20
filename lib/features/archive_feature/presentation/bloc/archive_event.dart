import 'package:equatable/equatable.dart';
import 'package:mindwrite/features/shared_bloc/data/model/note_model.dart';

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

class DeleteNoteArchiveEvent extends ArchiveEvent {
  final List<NoteModel> selectedNotes;

  const DeleteNoteArchiveEvent(this.selectedNotes);

  @override
  List<Object> get props => [selectedNotes];
}
