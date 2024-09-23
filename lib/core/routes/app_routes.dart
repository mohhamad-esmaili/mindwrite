import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mindwrite/features/archive_feature/presentation/screens/archive_view.dart';
import 'package:mindwrite/features/delete_feature/presentation/screens/delete_view.dart';
import 'package:mindwrite/features/draw_feature/presentation/screen/draw_view.dart';
import 'package:mindwrite/features/home_feature/presentation/screens/home_view.dart';
import 'package:mindwrite/features/label_feature/presentation/screens/label_view.dart';
import 'package:mindwrite/features/note_feature/presentation/screen/note_screen.dart';
import 'package:mindwrite/features/splash_feature/presentation/splash_view.dart';

class AppRoutes {
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        name: "splash",
        pageBuilder: (context, state) => CustomTransitionPage(
          child: const SplashView(),
          transitionDuration: const Duration(milliseconds: 500),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
                position: getOffsetAnimation(animation), child: child);
          },
        ),
      ),
      GoRoute(
        path: '/home',
        name: "home",
        pageBuilder: (context, state) => CustomTransitionPage(
          child: const HomeView(),
          transitionDuration: const Duration(milliseconds: 500),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
                position: getOffsetAnimation(animation), child: child);
          },
        ),
      ),
      GoRoute(
        path: '/create_note',
        name: "create_note",
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
        path: '/delete',
        name: "delete",
        pageBuilder: (context, state) => CustomTransitionPage(
          child: const DeleteView(),
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
          child: const ArchiveView(),
          transitionDuration: const Duration(milliseconds: 500),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
                position: getOffsetAnimation(animation), child: child);
          },
        ),
      ),
      GoRoute(
        path: '/label',
        name: "label",
        pageBuilder: (context, state) => CustomTransitionPage(
          child: LabelView(),
          transitionDuration: const Duration(milliseconds: 500),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
                position: getOffsetAnimation(animation), child: child);
          },
        ),
      ),
      GoRoute(
        path: '/draw',
        name: "draw",
        pageBuilder: (context, state) => CustomTransitionPage(
          child: const DrawView(),
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
