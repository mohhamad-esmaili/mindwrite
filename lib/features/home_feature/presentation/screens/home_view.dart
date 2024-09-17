import 'package:flutter/material.dart';
import 'package:mindwrite/locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindwrite/core/widgets/app_drawer.dart';
import 'package:mindwrite/core/widgets/note_widget.dart';
import 'package:mindwrite/core/widgets/snackbar_widget.dart';
import 'package:mindwrite/features/home_feature/data/model/note_model.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mindwrite/features/home_feature/presentation/bloc/home_bloc.dart';
import 'package:mindwrite/features/home_feature/presentation/widgets/home_appbar.dart';
import 'package:mindwrite/features/home_feature/domain/entities/note_model_entity.dart';
import 'package:mindwrite/features/home_feature/presentation/widgets/bottom_navbar.dart';
import 'package:mindwrite/features/home_feature/presentation/widgets/listview_title.dart';
import 'package:mindwrite/features/home_feature/presentation/widgets/floating_button.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Fetch latest notes when screen is loaded or refreshed
    context.read<HomeBloc>().add(GetAllNotesEvent());
  }

  @override
  Widget build(BuildContext context) {
    final snackbarService = locator<SnackbarService>();

    return Scaffold(
      key: _scaffoldKey,
      drawer: const AppDrawer(),
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Scrollbar(
                thickness: 2,
                radius: const Radius.circular(20),
                interactive: true,
                child: NestedScrollView(
                  floatHeaderSlivers: true,
                  headerSliverBuilder: (context, innerBoxIsScrolled) => [
                    SliverHomeAppbar(scaffoldKey: _scaffoldKey),
                  ],
                  body: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        BlocBuilder<HomeBloc, HomeState>(
                          builder: (context, state) {
                            if (state is HomeLoaded) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (state.pinnedNotes.isNotEmpty)
                                    const ListviewTitle(title: "Pinned"),
                                  MasonryGridView.count(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 8,
                                    crossAxisSpacing: 10,
                                    shrinkWrap: true,
                                    padding: const EdgeInsets.all(8.0),
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: state.pinnedNotes.length,
                                    itemBuilder: (context, index) {
                                      NoteModelEntity selectedNote =
                                          state.pinnedNotes[index];

                                      return NoteWidget(
                                          selectedNote: selectedNote,
                                          onDismissed: () {});
                                    },
                                  ),
                                  const ListviewTitle(title: "Others"),
                                  MasonryGridView.count(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 8,
                                    crossAxisSpacing: 10,
                                    shrinkWrap: true,
                                    padding: const EdgeInsets.all(8.0),
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: state.notes.length,
                                    itemBuilder: (context, index) {
                                      NoteModel selectedNote =
                                          state.notes[index];
                                      return NoteWidget(
                                        selectedNote: selectedNote,
                                        onDismissed: () async {
                                          bool undoPressed = false;
                                          final homeBloc =
                                              context.read<HomeBloc>();
                                          homeBloc.add(
                                              ToggleArchiveEvent(selectedNote));
                                          if (context.mounted) {
                                            await snackbarService
                                                .showStatusSnackbar(
                                              context: context,
                                              message: "Note archived",
                                              actionLabel: "Undo",
                                              onAction: () =>
                                                  undoPressed = true,
                                              onClosed: () {
                                                NoteModel archivedVersion =
                                                    selectedNote.copyWith(
                                                        archived: true);
                                                if (!undoPressed) {
                                                  homeBloc.add(
                                                      ToggleArchiveEvent(
                                                          selectedNote));
                                                } else {
                                                  homeBloc.add(
                                                      ToggleArchiveEvent(
                                                          archivedVersion));
                                                }
                                              },
                                            );
                                          }
                                        },
                                      );
                                    },
                                  ),
                                ],
                              );
                            } else if (state is HomeLoadFailed) {
                              return Center(
                                child: Text(
                                  'Failed to load notes: ${state.error}',
                                  style: const TextStyle(color: Colors.red),
                                ),
                              );
                            } else {
                              return const SizedBox
                                  .shrink(); // Empty state fallback
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: const FloatingButtonWidget(),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
      bottomNavigationBar: const HomeBottomBar(),
    );
  }
}
