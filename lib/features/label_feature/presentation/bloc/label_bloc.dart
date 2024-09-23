import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mindwrite/core/resources/data_state.dart';
import 'package:mindwrite/features/label_feature/domain/use_cases/delete_label_usecase.dart';
import 'package:mindwrite/features/label_feature/domain/use_cases/edit_label_usecase.dart';
import 'package:mindwrite/features/label_feature/domain/use_cases/load_labels_usecase.dart';
import 'package:mindwrite/features/label_feature/domain/use_cases/save_label_usecase.dart';
import 'package:mindwrite/features/label_feature/data/model/label_model.dart';

part 'label_event.dart';
part 'label_state.dart';

class LabelBloc extends Bloc<LabelEvent, LabelState> {
  List<LabelModel> labelList = [];
  String? errorMessage;
  LoadLabelsUsecase loadLabelsUsecase;
  SaveLabelUsecase saveLabelUsecase;
  EditLabelUsecase editLabelUsecase;
  DeleteLabelUsecase deleteLabelUsecase;
  LabelBloc(
    this.labelList,
    this.errorMessage,
    this.loadLabelsUsecase,
    this.saveLabelUsecase,
    this.editLabelUsecase,
    this.deleteLabelUsecase,
  ) : super(LabelInitial(labelList)) {
    on<LoadLabelsEvent>((event, emit) async {
      emit(LabelLoading());
      final result = await loadLabelsUsecase();
      if (result is DataSuccess<List<LabelModel>>) {
        print(result.data);
        emit(LabelInitial(result.data!));
      } else if (result is DataFailed) {
        emit(LabelFailed(result.error!));
      }
    });
    on<SaveLabelEvent>((event, emit) async {
      emit(LabelLoading());
      final result = await saveLabelUsecase(event.createdLabel);

      if (result is DataSuccess<LabelModel>) {
        labelList.insert(0, result.data!);
        emit(LabelInitial(labelList));
      } else if (result is DataFailed) {
        emit(LabelFailed(result.error!));
      }
    });

    on<EditLabelEvent>((event, emit) async {
      emit(LabelLoading());
      final result = await editLabelUsecase(event.selectedLabel);
      print(result.data!);
      if (result is DataSuccess<List<LabelModel>>) {
        emit(LabelInitial(result.data!));
      } else if (result is DataFailed) {
        emit(LabelFailed(result.error!));
      }
    });

    on<DeleteLabelEvent>((event, emit) async {
      emit(LabelLoading());

      final result = await deleteLabelUsecase(event.selectedLabel);
      if (result is DataSuccess<LabelModel>) {
        final res = await loadLabelsUsecase();
        emit(LabelInitial(res.data!));
      } else if (result is DataFailed) {
        emit(LabelFailed(result.error!));
      }
    });
  }
}
