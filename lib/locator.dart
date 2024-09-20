import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mindwrite/core/widgets/snackbar_widget.dart';
import 'package:mindwrite/features/archive_feature/data/repository/archive_repository_imp.dart';
import 'package:mindwrite/features/archive_feature/domain/repository/archive_repository.dart';
import 'package:mindwrite/features/archive_feature/domain/use_cases/get_archived_usecase.dart';
import 'package:mindwrite/features/archive_feature/presentation/bloc/archive_bloc.dart';
import 'package:mindwrite/features/delete_feature/data/repository/deleted_repository_imp.dart';
import 'package:mindwrite/features/delete_feature/domain/repository/deleted_repository.dart';
import 'package:mindwrite/features/delete_feature/domain/use_cases/get_deleted_usecase.dart';
import 'package:mindwrite/features/delete_feature/presentation/bloc/delete_bloc.dart';

import 'package:mindwrite/features/shared_bloc/data/model/background_model.dart';
import 'package:mindwrite/features/shared_bloc/data/model/color_adapter.dart';
import 'package:mindwrite/features/shared_bloc/data/model/label_model.dart';
import 'package:mindwrite/features/shared_bloc/data/model/note_model.dart';
import 'package:mindwrite/features/home_feature/data/repository/home_repository_imp.dart';
import 'package:mindwrite/features/home_feature/domain/repository/home_repository.dart';
import 'package:mindwrite/features/home_feature/domain/usecases/load_notes_usecase.dart';
import 'package:mindwrite/features/home_feature/domain/usecases/pinned_notes_usecase.dart';
import 'package:mindwrite/features/home_feature/presentation/bloc/home_bloc.dart';
import 'package:mindwrite/features/note_feature/data/repository/note_repository_imp.dart';
import 'package:mindwrite/features/note_feature/domain/repository/note_repository.dart';
import 'package:mindwrite/features/note_feature/domain/use_cases/save_note_usecase.dart';
import 'package:mindwrite/features/note_feature/presentation/bloc/note_bloc.dart';
import 'package:mindwrite/features/shared_bloc/domain/usecases/change_archive_usecase.dart';
import 'package:mindwrite/features/shared_bloc/domain/usecases/pin_note_usecase.dart';
import 'package:mindwrite/features/shared_bloc/presentation/bloc/shared_bloc.dart';
import 'package:mindwrite/features/shared_bloc/data/repository/shared_repository_imp.dart';
import 'package:mindwrite/features/shared_bloc/domain/repository/shared_repository.dart';
import 'package:mindwrite/features/shared_bloc/domain/usecases/delete_note_usecase.dart';
import 'package:mindwrite/features/shared_bloc/domain/usecases/restore_note_usecase.dart';

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
      id: null,
      lastUpdate: DateTime.now(),
      drawingsList: null,
      noteBackground: BackgroundModel(color: Colors.transparent),
    ),
  );

  locator.registerFactory<List<NoteModel>>(() => []);

  // app snackbar
  locator.registerSingleton<SnackbarService>(SnackbarService());

  /// Register NoteRepository
  locator.registerFactory<HomeRepository>(
    () => HomeRepositoryImp(createdNote: locator<NoteModel>()),
  );
  locator.registerFactory<NoteRepository>(() => NoteRepositoryImp());
  locator.registerFactory<ArchiveRepository>(() => ArchiveRepositoryImp());
  locator.registerFactory<DeletedRepository>(() => DeletedRepositoryImp());
  locator.registerFactory<SharedRepository>(() => SharedRepositoryImp());

  // usecases
  locator.registerFactory(
    () => SaveNoteToBoxUsecase(locator<NoteRepository>()),
  );
  locator.registerFactory(
    () => LoadNotesUsecase(locator<HomeRepository>()),
  );
  locator.registerFactory(
    () => LoadPinnedNotesUsecase(),
  );
  locator.registerFactory(
    () => GetArchivedUsecase(locator<ArchiveRepository>()),
  );
  locator.registerFactory(
    () => GetDeletedUsecase(locator<DeletedRepository>()),
  );
  locator.registerFactory(
    () => DeleteNoteUsecase(locator<SharedRepository>()),
  );
  locator.registerFactory(
    () => RestoreDeletedNoteUsecase(locator<SharedRepository>()),
  );
  locator.registerFactory(
    () => ToggleArchiveUsecase(locator<SharedRepository>()),
  );
  locator.registerFactory(
    () => PinToggleNoteUsecase(locator<SharedRepository>()),
  );

  // blocs
  locator.registerSingleton<HomeBloc>(HomeBloc(
    locator<List<NoteModel>>(),
    locator<LoadNotesUsecase>(),
    locator<LoadPinnedNotesUsecase>(),
  ));
  locator.registerSingleton<ArchiveBloc>(ArchiveBloc(
    locator<List<NoteModel>>(),
    locator<GetArchivedUsecase>(),
  ));
  locator.registerSingleton<NoteBloc>(NoteBloc(
    locator<NoteModel>(),
    locator<SaveNoteToBoxUsecase>(),
  ));
  locator.registerSingleton<DeleteBloc>(DeleteBloc(
    [],
    locator<GetDeletedUsecase>(),
  ));

  locator.registerSingleton<SharedBloc>(SharedBloc(
    false,
    [],
    locator<ToggleArchiveUsecase>(),
    locator<DeleteNoteUsecase>(),
    locator<RestoreDeletedNoteUsecase>(),
    locator<PinToggleNoteUsecase>(),
  ));
}
