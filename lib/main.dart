import 'package:flutter/material.dart';
import 'package:mindwrite/locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mindwrite/core/routes/app_routes.dart';
import 'package:mindwrite/core/config/theme_config.dart';
import 'package:mindwrite/features/archive_feature/presentation/bloc/archive_bloc.dart';
import 'package:mindwrite/features/archive_feature/presentation/bloc/archive_event.dart';
import 'package:mindwrite/features/delete_feature/presentation/bloc/delete_bloc.dart';
import 'package:mindwrite/features/delete_feature/presentation/bloc/delete_event.dart';
import 'package:mindwrite/features/home_feature/presentation/bloc/home_bloc.dart';
import 'package:mindwrite/features/label_feature/presentation/bloc/label_bloc.dart';
import 'package:mindwrite/features/note_feature/presentation/bloc/note_bloc.dart';
import 'package:mindwrite/features/shared_bloc/presentation/bloc/shared_bloc.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setup();

  runApp(const Root());
}

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => locator<SharedBloc>()..add(LoadThemeMode()),
        ),
        BlocProvider(
          create: (context) => locator<HomeBloc>()..add(LoadAllNotes()),
        ),
        BlocProvider(
          create: (context) =>
              locator<NoteBloc>()..add(const NoteInitialEvent()),
        ),
        BlocProvider(
          create: (context) =>
              locator<ArchiveBloc>()..add(const GetAllArchive()),
        ),
        BlocProvider(
          create: (context) =>
              locator<DeleteBloc>()..add(const GetAllDeleted()),
        ),
        BlocProvider(
          create: (context) => locator<LabelBloc>()..add(LoadLabelsEvent()),
        ),
      ],
      child: BlocBuilder<SharedBloc, SharedState>(
        builder: (context, state) {
          return MaterialApp.router(
            theme: state.themeMode == ThemeMode.light
                ? ThemeConfig.lightAppTheme
                : ThemeConfig.darkAppTheme,
            themeMode: state.themeMode,
            debugShowCheckedModeBanner: false,
            routerDelegate: AppRoutes.router.routerDelegate,
            routeInformationParser: AppRoutes.router.routeInformationParser,
            routeInformationProvider: AppRoutes.router.routeInformationProvider,
          );
        },
      ),
    );
  }
}
