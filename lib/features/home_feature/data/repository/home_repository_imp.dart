import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mindwrite/core/resources/data_state.dart';
import 'package:mindwrite/features/data/data_source/local/home_local_database.dart';
import 'package:mindwrite/features/data/models/note_model.dart';
import 'package:mindwrite/features/domain/entities/note_model_entity.dart';
import 'package:mindwrite/features/domain/repository/home_repository.dart';
import 'package:mindwrite/locator.dart';

class HomeRepositoryImp extends HomeRepository {
  final NoteModel createdNote;

  HomeRepositoryImp({required this.createdNote});
  HomeLocalDataBase homeLocalDataBase = HomeLocalDataBase();
  @override
  Future<DataState<List<NoteModel>>> loadNotesFromBox() async {
    try {
      List<NoteModel> allValues = await homeLocalDataBase.getListOfNotes();
      return DataSuccess(allValues);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }
}
