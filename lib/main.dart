import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:mindwrite/core/config/theme_config.dart';
import 'package:mindwrite/core/routes/app_routes.dart';
import 'package:mindwrite/features/data/models/note_model.dart';
import 'package:mindwrite/features/home_feature/presentation/bloc/home_bloc.dart';
import 'package:mindwrite/features/note_feature/presentation/bloc/note_bloc.dart';

import 'package:mindwrite/features/note_feature/presentation/screen/note_screen.dart';
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
          create: (context) => locator<HomeBloc>()..add(GetNotesEvent()),
        ),
        BlocProvider(
          create: (context) =>
              locator<NoteBloc>()..add(const NoteInitialEvent()),
        ),
      ],
      child: MaterialApp.router(
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
