import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindwrite/core/resources/data_state.dart';
import 'package:mindwrite/features/archive_feature/domain/use_cases/get_archived_usecase.dart';
import 'package:mindwrite/features/archive_feature/presentation/bloc/archive_event.dart';
import 'package:mindwrite/features/archive_feature/presentation/bloc/archive_state.dart';
import 'package:mindwrite/features/shared_bloc/data/model/note_model.dart';

class ArchiveBloc extends Bloc<ArchiveEvent, ArchiveState> {
  List<NoteModel> allArchivedNotes;
  GetArchivedUsecase getArchivedUsecase;

  ArchiveBloc(
    this.allArchivedNotes,
    this.getArchivedUsecase,
  ) : super(ArchiveInitial(allArchivedNotes)) {
    on<GetAllArchive>((event, emit) async {
      emit(const ArchiveLoading("loading"));
      final result = await getArchivedUsecase.call();
      if (result is DataSuccess<List<NoteModel>>) {
        emit(ArchiveLoaded(result.data!));
      } else if (result is DataFailed) {
        emit(ArchiveLoadFailed(result.error!));
      }
    });
  }
}
