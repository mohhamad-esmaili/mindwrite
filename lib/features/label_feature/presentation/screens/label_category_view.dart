import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindwrite/core/widgets/app_drawer.dart';
import 'package:mindwrite/core/widgets/masonary_builder.dart';
import 'package:mindwrite/core/widgets/screens_appbar.dart';
import 'package:mindwrite/features/home_feature/presentation/widgets/bottom_navbar.dart';
import 'package:mindwrite/features/home_feature/presentation/widgets/floating_button.dart';
import 'package:mindwrite/features/home_feature/presentation/widgets/listview_title.dart';
import 'package:mindwrite/features/label_feature/data/model/label_model.dart';
import 'package:mindwrite/features/label_feature/presentation/bloc/label_bloc.dart';
import 'package:mindwrite/features/shared_bloc/presentation/bloc/shared_bloc.dart';

class LabelCategoryView extends StatefulWidget {
  final LabelModel selectedLabel;
  const LabelCategoryView({super.key, required this.selectedLabel});

  @override
  State<LabelCategoryView> createState() => _LabelCategoryViewState();
}

class _LabelCategoryViewState extends State<LabelCategoryView> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<LabelBloc>(context)
        .add(LoadLabelNotesEvent(selectedLabel: widget.selectedLabel));
  }

  @override
  Widget build(BuildContext context) {
    SharedBloc sharedBloc = BlocProvider.of<SharedBloc>(context);
    BlocProvider.of<LabelBloc>(context)
        .add(LoadLabelNotesEvent(selectedLabel: widget.selectedLabel));
    return Scaffold(
      appBar: ScreensAppbar(
        appbarTitle: widget.selectedLabel.labelName,
        sharedBloc: sharedBloc,
        onDelete: () => BlocProvider.of<LabelBloc>(context)
            .add(LoadLabelNotesEvent(selectedLabel: widget.selectedLabel)),
      ),
      drawer: AppDrawer(
        selectedLabel: widget.selectedLabel.labelName,
      ),
      body: Column(
        children: [
          BlocBuilder<LabelBloc, LabelState>(
            builder: (context, state) {
              if (state is LabelNoteInitial) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (state.pinnednoteList.isNotEmpty)
                      const ListviewTitle(title: "Pinned"),
                    if (state.pinnednoteList.isNotEmpty)
                      MasonaryBuilder(
                        sharedBloc: sharedBloc,
                        noteModelList: state.pinnednoteList,
                        defaultArchiveNote: true,
                      ),
                    const ListviewTitle(title: "Others"),
                    MasonaryBuilder(
                      sharedBloc: sharedBloc,
                      noteModelList: state.noteList,
                      defaultArchiveNote: true,
                    ),
                  ],
                );
              } else if (state is LabelFailed) {
                return Center(
                  child: Text(
                    'Failed to load notes: ${state.error}',
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              } else {
                return const SizedBox.shrink(); // Empty state fallback
              }
            },
          ),
        ],
      ),
      floatingActionButton: const FloatingButtonWidget(),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
      bottomNavigationBar: const HomeBottomBar(),
    );
  }
}
