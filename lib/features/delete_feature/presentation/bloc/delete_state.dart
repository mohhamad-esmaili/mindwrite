import 'package:equatable/equatable.dart';
import 'package:mindwrite/features/shared_bloc/data/model/note_model.dart';

abstract class DeleteState extends Equatable {
  const DeleteState();
  @override
  List<Object> get props => [];
}

class DeleteInitial extends DeleteState {
  final List<NoteModel> deletedNotes;

  const DeleteInitial(this.deletedNotes);

  @override
  List<Object> get props => [deletedNotes];
}

class DeleteLoaded extends DeleteState {
  final List<NoteModel> deletedNotes;

  const DeleteLoaded(this.deletedNotes);

  @override
  List<Object> get props => [deletedNotes];
}

class DeleteLoading extends DeleteState {
  final String loading;

  const DeleteLoading(this.loading);

  @override
  List<Object> get props => [loading];
}

class DeleteLoadFailed extends DeleteState {
  final String error;

  const DeleteLoadFailed(this.error);

  @override
  List<Object> get props => [error];
}
