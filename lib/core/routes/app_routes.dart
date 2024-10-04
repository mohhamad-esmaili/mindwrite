import 'package:flutter/material.dart';
// Import the package
import 'package:go_router/go_router.dart';
import 'package:mindwrite/core/resources/note_arguments.dart';
import 'package:mindwrite/features/archive_feature/presentation/screens/archive_view.dart';
import 'package:mindwrite/features/delete_feature/presentation/screens/delete_view.dart';
import 'package:mindwrite/features/draw_feature/presentation/screen/draw_view.dart';
import 'package:mindwrite/features/home_feature/presentation/screens/home_view.dart';
import 'package:mindwrite/features/label_feature/data/model/label_model.dart';
import 'package:mindwrite/features/label_feature/presentation/screens/label_category_view.dart';
import 'package:mindwrite/features/label_feature/presentation/screens/label_selection.dart';
import 'package:mindwrite/features/label_feature/presentation/screens/label_view.dart';
import 'package:mindwrite/features/note_feature/presentation/screen/note_screen.dart';
import 'package:mindwrite/features/shared_bloc/data/model/note_model.dart';
import 'package:mindwrite/features/shared_bloc/presentation/screens/about_view.dart';
import 'package:mindwrite/features/shared_bloc/presentation/screens/settings_view.dart';
import 'package:mindwrite/features/splash_feature/presentation/splash_view.dart';
import 'package:mindwrite/locator.dart';

class AppRoutes {
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        name: "splash",
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: const SplashView(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return ScaleTransition(
                scale:
                    Tween<double>(begin: 0.8, end: 1.0).animate(CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeInOut,
                )),
                child: child,
              );
            },
          );
        },
      ),
      GoRoute(
        path: '/home',
        name: "home",
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: const HomeView(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return ScaleTransition(
                scale:
                    Tween<double>(begin: 0.8, end: 1.0).animate(CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeInOut,
                )),
                child: child,
              );
            },
          );
        },
      ),
      GoRoute(
        path: '/create_note',
        name: "create_note",
        pageBuilder: (context, state) {
          final args = state.extra as NoteArguments;
          final selectedNote = args.selectedNote ?? locator<NoteModel>();

          return CustomTransitionPage(
            child: PopScope(
              canPop: false,
              child: NoteView(
                selectedNote: selectedNote,
                editMode: args.editMode,
              ),
            ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return ScaleTransition(
                scale:
                    Tween<double>(begin: 0.8, end: 1.0).animate(CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeInOut,
                )),
                child: child,
              );
            },
          );
        },
      ),
      GoRoute(
        path: '/delete',
        name: "delete",
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: const DeleteView(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return ScaleTransition(
                scale:
                    Tween<double>(begin: 0.8, end: 1.0).animate(CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeInOut,
                )),
                child: child,
              );
            },
          );
        },
      ),
      GoRoute(
        path: '/archive',
        name: "archive",
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: const ArchiveView(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return ScaleTransition(
                scale:
                    Tween<double>(begin: 0.8, end: 1.0).animate(CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeInOut,
                )),
                child: child,
              );
            },
          );
        },
      ),
      GoRoute(
        path: '/label',
        name: "label",
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: const LabelView(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return ScaleTransition(
                scale:
                    Tween<double>(begin: 0.8, end: 1.0).animate(CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeInOut,
                )),
                child: child,
              );
            },
          );
        },
      ),
      GoRoute(
        path: '/label_category',
        name: "label_category",
        pageBuilder: (context, state) {
          final selectedLabel = state.extra as LabelModel;
          return CustomTransitionPage(
            child: LabelCategoryView(
              selectedLabel: selectedLabel,
            ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return ScaleTransition(
                scale:
                    Tween<double>(begin: 0.8, end: 1.0).animate(CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeInOut,
                )),
                child: child,
              );
            },
          );
        },
      ),
      GoRoute(
        path: '/label_selection',
        name: "label_selection",
        pageBuilder: (context, state) {
          final selectedNote = state.extra as NoteModel;
          return CustomTransitionPage(
            child: LabelSelectionView(
              selectedNote: selectedNote,
            ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return ScaleTransition(
                scale:
                    Tween<double>(begin: 0.8, end: 1.0).animate(CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeInOut,
                )),
                child: child,
              );
            },
          );
        },
      ),
      GoRoute(
        path: '/draw',
        name: "draw",
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: DrawView(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return ScaleTransition(
                scale:
                    Tween<double>(begin: 0.8, end: 1.0).animate(CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeInOut,
                )),
                child: child,
              );
            },
          );
        },
      ),
      GoRoute(
        path: '/setting',
        name: "setting",
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: const SettingsView(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return ScaleTransition(
                scale:
                    Tween<double>(begin: 0.8, end: 1.0).animate(CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeInOut,
                )),
                child: child,
              );
            },
          );
        },
      ),
      GoRoute(
        path: '/about',
        name: "about",
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: const AboutView(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return ScaleTransition(
                scale:
                    Tween<double>(begin: 0.8, end: 1.0).animate(CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeInOut,
                )),
                child: child,
              );
            },
          );
        },
      ),
    ],
  );
}
