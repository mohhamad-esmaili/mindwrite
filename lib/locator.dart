import 'dart:math';
import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mindwrite/features/data/models/background_model.dart';
import 'package:mindwrite/features/data/models/color_adapter.dart';
import 'package:mindwrite/features/data/models/label_model.dart';
import 'package:mindwrite/features/data/models/note_model.dart';
import 'package:mindwrite/features/data/repository/home_repository_imp.dart';
import 'package:mindwrite/features/domain/entities/note_model_entity.dart';
import 'package:mindwrite/features/domain/repository/home_repository.dart';
import 'package:mindwrite/features/domain/usecases/change_notecolor.dart';
import 'package:mindwrite/features/home_feature/presentation/bloc/home_bloc.dart';
import 'package:mindwrite/features/note_feature/data/repository/note_repository_imp.dart';
import 'package:mindwrite/features/note_feature/domain/repository/note_repository.dart';
import 'package:mindwrite/features/note_feature/domain/use_cases/save_note_usecase.dart';
import 'package:mindwrite/features/note_feature/presentation/bloc/note_bloc.dart';

GetIt locator = GetIt.instance;

setup() async {
  // Initialize Hive
  await Hive.initFlutter();
  Hive.registerAdapter(ColorAdapter());
  Hive
    ..registerAdapter(NoteModelAdapter())
    ..registerAdapter(BackgroundModelAdapter()) //
    ..registerAdapter(LabelModelAdapter()); //

  var noteBox = await Hive.openBox<NoteModel>('note_box');
  locator.registerSingleton<Box<NoteModel>>(noteBox);

  // Register NoteModel
  locator.registerFactory<NoteModel>(
    () => NoteModel(
      id: Random().nextInt(1000),
      title: null,
      description: null,
      lastUpdate: DateTime.now(),
      noteBackground: BackgroundModel(color: Colors.transparent),
    ),
  );

  locator.registerFactory<List<NoteModel>>(() => []);

  // Register NoteRepository
  locator.registerFactory<HomeRepository>(
      () => HomeRepositoryImp(createdNote: locator<NoteModel>()));
  locator.registerFactory<NoteRepository>(() => NoteRepositoryImp());

  // usecases
  locator
      .registerFactory(() => SaveNoteToBoxUsecase(locator<NoteRepository>()));
  locator.registerFactory(() => LoadAllNotes(locator<HomeRepository>()));

  // blocs
  locator.registerSingleton<HomeBloc>(
      HomeBloc(locator<List<NoteModel>>(), locator<LoadAllNotes>()));
  locator.registerSingleton<NoteBloc>(
      NoteBloc(locator<NoteModel>(), locator<SaveNoteToBoxUsecase>()));
}
