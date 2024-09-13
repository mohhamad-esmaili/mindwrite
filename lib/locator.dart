import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mindwrite/features/archive_feature/data/repository/archive_repository_imp.dart';
import 'package:mindwrite/features/archive_feature/domain/repository/archive_repository.dart';
import 'package:mindwrite/features/archive_feature/domain/use_cases/get_archived_usecase.dart';
import 'package:mindwrite/features/archive_feature/presentation/bloc/archive_bloc.dart';
import 'package:mindwrite/features/home_feature/data/model/background_model.dart';
import 'package:mindwrite/features/home_feature/data/model/color_adapter.dart';
import 'package:mindwrite/features/home_feature/data/model/label_model.dart';
import 'package:mindwrite/features/home_feature/data/model/note_model.dart';
import 'package:mindwrite/features/home_feature/data/repository/home_repository_imp.dart';
import 'package:mindwrite/features/home_feature/domain/repository/home_repository.dart';
import 'package:mindwrite/features/home_feature/domain/usecases/change_archive_usecase.dart';
import 'package:mindwrite/features/home_feature/domain/usecases/load_notes_usecase.dart';
import 'package:mindwrite/features/home_feature/domain/usecases/pinned_notes_usecase.dart';
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
  locator.registerFactory<ArchiveRepository>(() => ArchiveRepositoryImp());

  // usecases
  locator
      .registerFactory(() => SaveNoteToBoxUsecase(locator<NoteRepository>()));
  locator
      .registerFactory(() => LoadAllArchivedUsecase(locator<HomeRepository>()));
  locator.registerFactory(() => LoadPinnedNotesUsecase());
  locator
      .registerFactory(() => ChangeArchiveUsecase(locator<HomeRepository>()));
  locator
      .registerFactory(() => GetArchivedUsecase(locator<ArchiveRepository>()));

  // blocs
  locator.registerSingleton<HomeBloc>(
    HomeBloc(locator<List<NoteModel>>(), locator<LoadAllArchivedUsecase>(),
        locator<LoadPinnedNotesUsecase>(), locator<ChangeArchiveUsecase>()),
  );
  locator.registerSingleton<ArchiveBloc>(ArchiveBloc(
    locator<List<NoteModel>>(),
    locator<GetArchivedUsecase>(),
    locator<ChangeArchiveUsecase>(),
  ));

  locator.registerSingleton<NoteBloc>(
      NoteBloc(locator<NoteModel>(), locator<SaveNoteToBoxUsecase>()));
}
