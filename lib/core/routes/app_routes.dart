import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mindwrite/features/archive_feature/presentation/screens/archive_view.dart';
import 'package:mindwrite/features/home_feature/presentation/screens/home_view.dart';
import 'package:mindwrite/features/note_feature/presentation/screen/note_screen.dart';

class AppRoutes {
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        name: "home",
        pageBuilder: (context, state) => CustomTransitionPage(
          child: HomeView(),
          transitionDuration: const Duration(milliseconds: 500),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
                position: getOffsetAnimation(animation), child: child);
          },
        ),
      ),
      GoRoute(
        path: '/create_note',
        name: "note_view",
        pageBuilder: (context, state) => CustomTransitionPage(
          child: NoteView(),
          transitionDuration: const Duration(milliseconds: 500),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
                position: getOffsetAnimation(animation), child: child);
          },
        ),
      ),
      GoRoute(
        path: '/archive',
        name: "archive",
        pageBuilder: (context, state) => CustomTransitionPage(
          child: ArchiveView(),
          transitionDuration: const Duration(milliseconds: 500),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
                position: getOffsetAnimation(animation), child: child);
          },
        ),
      ),
    ],
  );
  static Animation<Offset> getOffsetAnimation(Animation<double> animation) {
    const begin = Offset(1.0, 0.0);
    const end = Offset.zero;
    const curve = Curves.easeInOut;
    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    return animation.drive(tween);
  }
}
