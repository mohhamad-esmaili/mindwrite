import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mindwrite/core/config/theme_config.dart';
import 'package:mindwrite/core/routes/app_routes.dart';
import 'package:mindwrite/features/archive_feature/presentation/bloc/archive_bloc.dart';
import 'package:mindwrite/features/archive_feature/presentation/bloc/archive_event.dart';
import 'package:mindwrite/features/home_feature/presentation/bloc/home_bloc.dart';
import 'package:mindwrite/features/note_feature/presentation/bloc/note_bloc.dart';

import 'package:mindwrite/locator.dart';

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
          create: (context) => locator<HomeBloc>()..add(GetAllNotesEvent()),
        ),
        BlocProvider(
          create: (context) =>
              locator<NoteBloc>()..add(const NoteInitialEvent()),
        ),
        BlocProvider(
          create: (context) =>
              locator<ArchiveBloc>()..add(const GetAllArchive()),
        ),
      ],
      child: MaterialApp.router(
        // theme: ThemeConfig.darkAppTheme,
        theme: ThemeConfig.darkAppTheme,
        themeMode: ThemeMode.dark,
        debugShowCheckedModeBanner: false,
        routerDelegate: AppRoutes.router.routerDelegate,
        routeInformationParser: AppRoutes.router.routeInformationParser,
        routeInformationProvider: AppRoutes.router.routeInformationProvider,
      ),
    );
  }
}
