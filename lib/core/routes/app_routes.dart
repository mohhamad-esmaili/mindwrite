import 'package:go_router/go_router.dart';
import 'package:mindwrite/features/home_feature/screens/home_view.dart';
import 'package:mindwrite/features/note_feature/screen/note_screen.dart';

class AppRoutes {
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => HomeView(),
      ),
      GoRoute(
        path: '/create_note',
        builder: (context, state) => NoteView(),
      ),
    ],
  );
}
