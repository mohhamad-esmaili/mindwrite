import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:mindwrite/core/utils/color_constants.dart';
import 'package:mindwrite/core/widgets/app_drawer.dart';
import 'package:mindwrite/core/widgets/circular_indicator_widget.dart';
import 'package:mindwrite/features/home_feature/data/models/note_model.dart';
import 'package:mindwrite/features/home_feature/domain/entities/note_model_entity.dart';
import 'package:mindwrite/features/home_feature/presentation/bloc/home_bloc.dart';
import 'package:mindwrite/features/home_feature/presentation/widgets/bottom_navbar.dart';
import 'package:mindwrite/features/home_feature/presentation/widgets/home_appbar.dart';
import 'package:mindwrite/features/home_feature/presentation/widgets/listview_title.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        context.read<HomeBloc>().add(GetNotesEvent());
        if (state is HomeInitial) {
          return const Center(child: CircularIndicatorWidget());
        } else if (state is HomeLoaded) {
          return Scaffold(
            key: _scaffoldKey,
            drawer: const AppDrawer(),
            extendBodyBehindAppBar: true,
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: Scrollbar(
                thickness: 2,
                radius: const Radius.circular(20),
                interactive: true,
                child: NestedScrollView(
                  floatHeaderSlivers: true,
                  headerSliverBuilder: (context, innerBoxIsScrolled) => [
                    SliverHomeAppbar(
                      scaffoldKey: _scaffoldKey,
                    )
                  ],
                  body: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        state.pinnedNotes.isNotEmpty
                            ? const ListviewTitle(title: "Pinnded")
                            : const SizedBox(),
                        MasonryGridView.count(
                          crossAxisCount: 2, // تعداد ستون‌ها
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 10,
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(8.0),
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.pinnedNotes.length,
                          itemBuilder: (context, index) {
                            NoteModelEntity selectedNote =
                                state.pinnedNotes[index];
                            //TODO: make fade when dismissing
                            return Dismissible(
                              key: Key(selectedNote.id.toString()),
                              resizeDuration: const Duration(milliseconds: 600),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: selectedNote.noteBackground!.color,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: selectedNote.noteBackground!.color ==
                                            Colors.transparent
                                        ? Colors.grey
                                        : selectedNote.noteBackground!.color,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        selectedNote.title!,
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        selectedNote.description!,
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        const ListviewTitle(title: "Others"),
                        MasonryGridView.count(
                          crossAxisCount: 2, // تعداد ستون‌ها
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 10,
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(8.0),
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.notes.length,
                          itemBuilder: (context, index) {
                            NoteModelEntity selectedNote = state.notes[index];
                            return Container(
                              decoration: BoxDecoration(
                                color: selectedNote.noteBackground!.color,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: selectedNote.noteBackground!.color ==
                                          Colors.transparent
                                      ? Colors.grey
                                      : selectedNote.noteBackground!.color,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      selectedNote.title!,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      selectedNote.description!,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            floatingActionButton: Container(
              height: 75,
              width: 75,
              margin: const EdgeInsets.only(bottom: 10),
              child: FloatingActionButton(
                onPressed: () => context.go('/create_note'),
                backgroundColor: const Color.fromRGBO(41, 42, 44, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Icon(
                  Icons.add,
                  size: 55,
                  color: themeData.iconTheme.color,
                ),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.miniEndDocked,
            bottomNavigationBar: const HomeBottomBar(),
          );
        } else if (state is HomeLoadFailed) {
          return Scaffold(
            body: Center(child: Text('Failed to load notes: ${state.error}')),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
