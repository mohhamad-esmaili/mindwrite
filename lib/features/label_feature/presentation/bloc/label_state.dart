part of 'label_bloc.dart';

sealed class LabelState extends Equatable {
  const LabelState();

  @override
  List<Object> get props => [];
}

final class LabelInitial extends LabelState {
  final List<LabelModel> labelList;
  const LabelInitial(this.labelList);
  @override
  List<Object> get props => [labelList];
}

final class LabelLoading extends LabelState {}

final class LabelLoaded extends LabelState {}

final class LabelFailed extends LabelState {
  final String error;
  const LabelFailed(this.error);
  @override
  List<Object> get props => [error];
}
