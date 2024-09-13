import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindwrite/core/resources/data_state.dart';
import 'package:mindwrite/features/archive_feature/domain/use_cases/get_archived_usecase.dart';
import 'package:mindwrite/features/archive_feature/presentation/bloc/archive_event.dart';
import 'package:mindwrite/features/archive_feature/presentation/bloc/archive_state.dart';
import 'package:mindwrite/features/home_feature/data/model/note_model.dart';
import 'package:mindwrite/features/home_feature/domain/usecases/change_archive_usecase.dart';
import 'package:mindwrite/features/home_feature/presentation/bloc/home_bloc.dart';
import 'package:mindwrite/locator.dart';

class ArchiveBloc extends Bloc<ArchiveEvent, ArchiveState> {
  List<NoteModel> allArchivedNotes;
  GetArchivedUsecase getArchivedUsecase;
  ChangeArchiveUsecase changeArchiveUsecase;
  ArchiveBloc(
      this.allArchivedNotes, this.getArchivedUsecase, this.changeArchiveUsecase)
      : super(ArchiveInitial(allArchivedNotes)) {
    on<GetAllArchive>((event, emit) async {
      emit(ArchiveLoading("loading"));
      final result = await getArchivedUsecase.call();
      if (result is DataSuccess<List<NoteModel>>) {
        emit(ArchiveLoaded(result.data!));
      } else if (result is DataFailed) {
        emit(ArchiveLoadFailed(result.error!));
      }
    });
    on<ToggleOffArchiveEvent>((event, emit) async {
      emit(const ArchiveLoading("loading"));
      print("inside bloc");
      print(event.note.archived);

      await changeArchiveUsecase(event.note);

      print("inside bloc");
      // Remove the note from the list
      allArchivedNotes.remove(event.note);
      final result = await getArchivedUsecase();
      print(result.data);

      if (result is DataSuccess<List<NoteModel>>) {
        emit(ArchiveLoaded(result.data!));
      } else if (result is DataFailed) {
        emit(ArchiveLoadFailed(result.error!));
      }
    });
  }
}
