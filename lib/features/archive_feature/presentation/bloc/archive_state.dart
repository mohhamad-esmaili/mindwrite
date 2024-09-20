import 'package:equatable/equatable.dart';
import 'package:mindwrite/features/shared_bloc/data/model/note_model.dart';

abstract class ArchiveState extends Equatable {
  const ArchiveState();
  @override
  List<Object> get props => [];
}

class ArchiveInitial extends ArchiveState {
  final List<NoteModel> archivedNotes;

  const ArchiveInitial(this.archivedNotes);

  @override
  List<Object> get props => [archivedNotes];
}

class ArchiveLoaded extends ArchiveState {
  final List<NoteModel> archivedNotes;

  const ArchiveLoaded(this.archivedNotes);

  @override
  List<Object> get props => [archivedNotes];
}

class ArchiveLoading extends ArchiveState {
  final String loading;

  const ArchiveLoading(this.loading);

  @override
  List<Object> get props => [loading];
}

class ArchiveLoadFailed extends ArchiveState {
  final String error;

  const ArchiveLoadFailed(this.error);

  @override
  List<Object> get props => [error];
}
