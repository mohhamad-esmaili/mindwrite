import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:mindwrite/features/data/models/note_model.dart';
import 'package:mindwrite/features/note_feature/bloc/note_bloc.dart';

import 'package:mindwrite/features/note_feature/screen/note_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(NoteModelAdapter()); // this should be first
  await Hive.openBox('user_box');

  runApp(Root());
}

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NoteBloc()..add(LoadNoteEvent()),
        ),
      ],
      child: MaterialApp(
        themeMode: ThemeMode.dark,
        home: NoteView(),
      ),
    );
  }
}
