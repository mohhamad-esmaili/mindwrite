import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mindwrite/core/widgets/app_drawer.dart';
import 'package:mindwrite/core/widgets/masonary_builder.dart';
import 'package:mindwrite/core/widgets/screens_appbar.dart';
import 'package:mindwrite/features/archive_feature/presentation/bloc/archive_bloc.dart';
import 'package:mindwrite/features/archive_feature/presentation/bloc/archive_event.dart';
import 'package:mindwrite/features/archive_feature/presentation/bloc/archive_state.dart';

import 'package:mindwrite/features/shared_bloc/presentation/bloc/shared_bloc.dart';

class ArchiveView extends StatefulWidget {
  const ArchiveView({super.key});

  @override
  State<ArchiveView> createState() => _ArchiveViewState();
}

class _ArchiveViewState extends State<ArchiveView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Fetch latest notes when screen is loaded or refreshed
    context.read<ArchiveBloc>().add(const GetAllArchive());
  }

  @override
  Widget build(BuildContext context) {
    SharedBloc sharedBloc = BlocProvider.of<SharedBloc>(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: ScreensAppbar(
        appbarTitle: "Archive",
        sharedBloc: sharedBloc,
      ),
      drawer: const AppDrawer(),
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Scrollbar(
                thickness: 2,
                radius: const Radius.circular(20),
                interactive: true,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      BlocBuilder<ArchiveBloc, ArchiveState>(
                        builder: (context, state) {
                          if (state is ArchiveLoaded) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MasonaryBuilder(
                                    noteModelList: state.archivedNotes,
                                    defaultArchiveNote: false,
                                    sharedBloc: sharedBloc),
                              ],
                            );
                          } else if (state is ArchiveLoadFailed) {
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
          ],
        ),
      ),
    );
  }
}
