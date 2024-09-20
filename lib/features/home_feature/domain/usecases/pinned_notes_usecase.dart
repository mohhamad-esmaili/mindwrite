import 'package:mindwrite/core/usecase/use_case.dart';
import 'package:mindwrite/core/resources/data_state.dart';
import 'package:mindwrite/features/shared_bloc/data/model/note_model.dart';

class LoadPinnedNotesUsecase
    implements UseCase<List<NoteModel>, DataState<List<NoteModel>>> {
  @override
  Future<List<NoteModel>> call(DataState<List<NoteModel>> param) async {
    return param.data!.where((element) => element.pin == true).toList();
  }
}
