import 'package:flutter/material.dart';
import 'package:mindwrite/core/resources/data_state.dart';
import 'package:mindwrite/features/shared_bloc/data/model/note_model.dart';

abstract class SharedRepository {
  Future<DataState<ThemeMode>> loadThemeMode();
  Future<DataState<ThemeMode>> toggleThemeMode();
  Future<DataState<List<NoteModel>>> toggleArchiveStatusToBox(
      List<NoteModel> notes);
  Future<DataState<List<NoteModel>>> restoreNoteToBox(List<NoteModel> notes);
  Future<DataState<List<NoteModel>>> deleteNote(List<NoteModel> notes);
  Future<DataState<List<NoteModel>>> pinToggle(List<NoteModel> notes);
  Future<DataState<List<NoteModel>>> changePalette(List<NoteModel> notes);
}
