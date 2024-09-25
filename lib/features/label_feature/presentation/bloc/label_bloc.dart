import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mindwrite/core/resources/data_state.dart';
import 'package:mindwrite/features/home_feature/domain/usecases/pinned_notes_usecase.dart';
import 'package:mindwrite/features/label_feature/domain/use_cases/delete_label_usecase.dart';
import 'package:mindwrite/features/label_feature/domain/use_cases/edit_label_usecase.dart';
import 'package:mindwrite/features/label_feature/domain/use_cases/edit_note_labels.dart';
import 'package:mindwrite/features/label_feature/domain/use_cases/load_label_notes.dart';
import 'package:mindwrite/features/label_feature/domain/use_cases/load_labels_usecase.dart';
import 'package:mindwrite/features/label_feature/domain/use_cases/save_label_usecase.dart';
import 'package:mindwrite/features/label_feature/data/model/label_model.dart';
import 'package:mindwrite/features/shared_bloc/data/model/note_model.dart';

part 'label_event.dart';
part 'label_state.dart';

class LabelBloc extends Bloc<LabelEvent, LabelState> {
  List<LabelModel> labelList = [];
  List<NoteModel> labelNotes = [];
  List<NoteModel> labelPinnedNotes = [];
  LoadLabelsUsecase loadLabelsUsecase;
  LoadLabelNotessUsecase loadLabelNotessUsecase;
  SaveLabelUsecase saveLabelUsecase;
  EditLabelUsecase editLabelUsecase;
  DeleteLabelUsecase deleteLabelUsecase;
  LoadPinnedNotesUsecase loadPinnedNotesUsecase;
  EditNoteLabelsUsecase editNoteLabelsUsecase;
  LabelBloc(
    this.labelList,
    this.labelNotes,
    this.labelPinnedNotes,
    this.loadLabelsUsecase,
    this.loadLabelNotessUsecase,
    this.saveLabelUsecase,
    this.editLabelUsecase,
    this.deleteLabelUsecase,
    this.loadPinnedNotesUsecase,
    this.editNoteLabelsUsecase,
  ) : super(LabelInitial(labelList)) {
    on<LoadLabelsEvent>((event, emit) async {
      emit(LabelLoading());
      final result = await loadLabelsUsecase();
      if (result is DataSuccess<List<LabelModel>>) {
        emit(LabelInitial(result.data!));
      } else if (result is DataFailed) {
        emit(LabelFailed(result.error!));
      }
    });
    on<LoadLabelNotesEvent>((event, emit) async {
      emit(LabelLoading());
      final result = await loadLabelNotessUsecase(event.selectedLabel);
      if (result is DataSuccess<List<NoteModel>>) {
        labelPinnedNotes = await loadPinnedNotesUsecase(result);

        emit(LabelNoteInitial(result.data!, labelPinnedNotes));
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
    on<EditNoteLabelsEvent>((event, emit) async {
      emit(LabelLoading());
      NoteModel selectedNote = event.selectedNote;
      List<LabelModel> updatedLabels =
          List<LabelModel>.from(selectedNote.labels ?? []);

      if (updatedLabels.contains(event.selectedLabel)) {
        updatedLabels.remove(event.selectedLabel);
      } else {
        updatedLabels.add(event.selectedLabel);
      }
      NoteModel note = selectedNote.copyWith(labels: updatedLabels);

      final result = await editNoteLabelsUsecase(note);

      if (result is DataSuccess<NoteModel>) {
        final loadedLabels = await loadLabelsUsecase();
        emit(LabelInitial(loadedLabels.data!));
      } else if (result is DataFailed) {
        emit(LabelFailed(result.error!));
      }
    });

    on<EditLabelEvent>((event, emit) async {
      emit(LabelLoading());
      final result = await editLabelUsecase(event.selectedLabel);

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
