import 'package:flutter/material.dart';
import 'package:mindwrite/core/widgets/masonary_builder.dart';
import 'package:mindwrite/core/widgets/screens_appbar.dart';
import 'package:mindwrite/features/shared_bloc/presentation/bloc/shared_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindwrite/core/widgets/app_drawer.dart';
import 'package:mindwrite/core/widgets/snackbar_widget.dart';
import 'package:mindwrite/features/shared_bloc/data/model/note_model.dart';
import 'package:mindwrite/features/home_feature/presentation/bloc/home_bloc.dart';
import 'package:mindwrite/features/home_feature/presentation/widgets/home_appbar.dart';
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
    SharedBloc sharedBloc = BlocProvider.of<SharedBloc>(context);
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
                    SliverHomeAppbar(
                      scaffoldKey: _scaffoldKey,
                      sharedBloc: sharedBloc,
                    ),
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
                                  MasonaryBuilder(
                                    sharedBloc: sharedBloc,
                                    noteModelList: state.pinnedNotes,
                                    defaultArchiveNote: true,
                                  ),
                                  const ListviewTitle(title: "Others"),
                                  MasonaryBuilder(
                                    sharedBloc: sharedBloc,
                                    noteModelList: state.notes,
                                    defaultArchiveNote: true,
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
