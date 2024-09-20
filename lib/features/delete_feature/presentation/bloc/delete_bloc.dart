import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindwrite/core/resources/data_state.dart';

import 'package:mindwrite/features/delete_feature/domain/use_cases/get_deleted_usecase.dart';
import 'package:mindwrite/features/delete_feature/presentation/bloc/delete_event.dart';
import 'package:mindwrite/features/delete_feature/presentation/bloc/delete_state.dart';
import 'package:mindwrite/features/shared_bloc/data/model/note_model.dart';

class DeleteBloc extends Bloc<DeleteEvent, DeleteState> {
  List<NoteModel> allDeletedNotes;
  GetDeletedUsecase getDeletedUsecase;

  DeleteBloc(this.allDeletedNotes, this.getDeletedUsecase)
      : super(DeleteInitial(allDeletedNotes)) {
    on<GetAllDeleted>((event, emit) async {
      emit(const DeleteLoading("loading"));
      final result = await getDeletedUsecase();
      allDeletedNotes = result.data ?? [];
      if (result is DataSuccess<List<NoteModel>>) {
        emit(DeleteLoaded(allDeletedNotes));
      } else if (result is DataFailed) {
        emit(DeleteLoadFailed(result.error!));
      }
    });
  }
}
