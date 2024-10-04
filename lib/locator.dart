import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mindwrite/core/enums/listmode_enum.dart';
import 'package:mindwrite/core/widgets/snackbar_widget.dart';
import 'package:mindwrite/features/archive_feature/data/repository/archive_repository_imp.dart';
import 'package:mindwrite/features/archive_feature/domain/repository/archive_repository.dart';
import 'package:mindwrite/features/archive_feature/domain/use_cases/get_archived_usecase.dart';
import 'package:mindwrite/features/archive_feature/presentation/bloc/archive_bloc.dart';
import 'package:mindwrite/features/delete_feature/data/repository/deleted_repository_imp.dart';
import 'package:mindwrite/features/delete_feature/domain/repository/deleted_repository.dart';
import 'package:mindwrite/features/delete_feature/domain/use_cases/delete_notes_forever_usecase.dart';
import 'package:mindwrite/features/delete_feature/domain/use_cases/get_deleted_usecase.dart';
import 'package:mindwrite/features/delete_feature/presentation/bloc/delete_bloc.dart';
import 'package:mindwrite/features/label_feature/data/repository/label_repository_imp.dart';
import 'package:mindwrite/features/label_feature/domain/repository/label_repository.dart';
import 'package:mindwrite/features/label_feature/domain/use_cases/delete_label_usecase.dart';
import 'package:mindwrite/features/label_feature/domain/use_cases/edit_label_usecase.dart';
import 'package:mindwrite/features/label_feature/domain/use_cases/edit_note_labels.dart';
import 'package:mindwrite/features/label_feature/domain/use_cases/load_label_notes.dart';
import 'package:mindwrite/features/label_feature/domain/use_cases/load_labels_usecase.dart';
import 'package:mindwrite/features/label_feature/domain/use_cases/save_label_usecase.dart';
import 'package:mindwrite/features/label_feature/presentation/bloc/label_bloc.dart';

import 'package:mindwrite/features/shared_bloc/data/model/background_model.dart';
import 'package:mindwrite/core/utils/color_adapter.dart';
import 'package:mindwrite/features/label_feature/data/model/label_model.dart';
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
import 'package:mindwrite/features/shared_bloc/domain/usecases/change_paletter_usecase.dart';
import 'package:mindwrite/features/shared_bloc/domain/usecases/load_theme_usecase.dart';
import 'package:mindwrite/features/shared_bloc/domain/usecases/pin_note_usecase.dart';
import 'package:mindwrite/features/shared_bloc/domain/usecases/toggle_theme_usecase.dart';
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
    ..registerAdapter(BackgroundModelAdapter())
    ..registerAdapter(LabelModelAdapter());

  var noteBox = await Hive.openBox<NoteModel>('note_box');
  var labelBox = await Hive.openBox<LabelModel>('label_box');
  var appBox = await Hive.openBox('app_box');
  locator.registerSingleton<Box<NoteModel>>(noteBox, instanceName: "note_box");
  locator.registerSingleton<Box<LabelModel>>(labelBox,
      instanceName: "label_box");
  locator.registerSingleton<Box>(appBox, instanceName: "app_box");

  // Register NoteModel
  locator.registerFactory<NoteModel>(
    () => NoteModel(
        title: null,
        description: null,
        id: null,
        lastUpdate: DateTime.now(),
        drawingsList: null,
        noteBackground: BackgroundModel(
          darkColor: Colors.transparent,
          lightColor: const Color.fromRGBO(244, 247, 252, 1),
          lightBackgroundPath: null,
          darkBackgroundPath: null,
        )),
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
  locator.registerFactory<LabelRepository>(() => LabelRepositoryImp());

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
    () => DeleteNotesForeverUsecase(locator<DeletedRepository>()),
  );
  locator.registerFactory(
    () => DeleteNoteUsecase(locator<SharedRepository>()),
  );
  locator.registerFactory(
    () => LoadThemeUsecase(locator<SharedRepository>()),
  );
  locator.registerFactory(
    () => ToggleThemeUsecase(locator<SharedRepository>()),
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
  locator.registerFactory(
    () => ChangePaletterUsecase(locator<SharedRepository>()),
  );
  locator.registerFactory(
    () => LoadLabelsUsecase(locator<LabelRepository>()),
  );
  locator.registerFactory(
    () => SaveLabelUsecase(locator<LabelRepository>()),
  );
  locator.registerFactory(
    () => DeleteLabelUsecase(locator<LabelRepository>()),
  );
  locator.registerFactory(
    () => EditLabelUsecase(locator<LabelRepository>()),
  );
  locator.registerFactory(
    () => LoadLabelNotessUsecase(locator<LabelRepository>()),
  );
  locator.registerFactory(
    () => EditNoteLabelsUsecase(locator<LabelRepository>()),
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
    locator<DeleteNotesForeverUsecase>(),
  ));

  locator.registerSingleton<SharedBloc>(SharedBloc(
    false,
    [],
    ListModeEnum.multiple,
    locator<ToggleArchiveUsecase>(),
    locator<DeleteNoteUsecase>(),
    locator<RestoreDeletedNoteUsecase>(),
    locator<PinToggleNoteUsecase>(),
    locator<ChangePaletterUsecase>(),
    locator<LoadThemeUsecase>(),
    locator<ToggleThemeUsecase>(),
  ));
  locator.registerSingleton<LabelBloc>(LabelBloc(
    [],
    [],
    [],
    locator<LoadLabelsUsecase>(),
    locator<LoadLabelNotessUsecase>(),
    locator<SaveLabelUsecase>(),
    locator<EditLabelUsecase>(),
    locator<DeleteLabelUsecase>(),
    locator<LoadPinnedNotesUsecase>(),
    locator<EditNoteLabelsUsecase>(),
  ));
}
