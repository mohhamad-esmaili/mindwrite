import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart'; // Import the package
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mindwrite/core/resources/note_arguments.dart';

import 'package:mindwrite/core/widgets/circular_indicator_widget.dart';
import 'package:mindwrite/features/label_feature/data/model/label_model.dart';
import 'package:mindwrite/features/label_feature/presentation/bloc/label_bloc.dart';
import 'package:mindwrite/features/note_feature/presentation/bloc/note_bloc.dart';
import 'package:mindwrite/features/shared_bloc/data/model/note_model.dart';

class LabelSelectionView extends StatefulWidget {
  final NoteModel selectedNote;
  const LabelSelectionView({super.key, required this.selectedNote});

  @override
  State<LabelSelectionView> createState() => _LabelSelectionViewState();
}

class _LabelSelectionViewState extends State<LabelSelectionView> {
  late NoteModel updatedNote;
  late List<LabelModel> allLabels;
  late TextEditingController _searchController;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    updatedNote = widget.selectedNote.copyWith();
    allLabels = List<LabelModel>.from(widget.selectedNote.labels ?? []);
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.read<LabelBloc>().add(LoadLabelsEvent());
    ThemeData themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context
                .read<NoteBloc>()
                .add(RefreshNoteDataEvent(refreshedNote: updatedNote));
            context.go("/create_note",
                extra:
                    NoteArguments(selectedNote: updatedNote, editMode: true));
          },
        ),
        title: TextField(
          controller: _searchController,
          maxLength: 20,
          decoration: InputDecoration(
            hintText: 'Search labels...',
            border: InputBorder.none,
            counterText: "",
            hintStyle: themeData.textTheme.labelMedium,
          ),
          style: themeData.textTheme.labelMedium,
          onChanged: (query) {
            setState(() {
              searchQuery = query.toLowerCase();
            });
          },
        ),
      ),
      body: BlocBuilder<LabelBloc, LabelState>(
        builder: (context, state) {
          if (state is LabelLoading) {
            return const CircularIndicatorWidget();
          } else if (state is LabelInitial) {
            // Filter labels based on search query
            final filteredLabels = state.labelList.where((label) {
              return label.labelName.toLowerCase().contains(searchQuery);
            }).toList();

            return ListView.builder(
              itemCount: filteredLabels.length,
              itemBuilder: (context, index) {
                LabelModel selectedLabel = filteredLabels[index];
                bool isSelected = allLabels.contains(selectedLabel);

                return Animate(
                  effects: const [
                    FadeEffect(duration: Duration(milliseconds: 300)),
                    SlideEffect(
                      duration: Duration(milliseconds: 500),
                      begin: Offset(0, 0.3),
                      end: Offset.zero,
                      curve: Curves.easeOut,
                    ),
                  ],
                  child: ListTile(
                    onTap: () {
                      setState(() {
                        if (!isSelected) {
                          allLabels.add(selectedLabel);
                        } else {
                          allLabels.remove(selectedLabel);
                        }

                        updatedNote = updatedNote.copyWith(labels: allLabels);
                        _searchController.clear();
                        FocusScope.of(context).unfocus();
                        searchQuery = '';
                      });
                    },
                    minLeadingWidth: 40,
                    minTileHeight: 60,
                    leading: Icon(
                      Icons.label_outline_rounded,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    title: Text(
                      selectedLabel.labelName,
                      style: themeData.textTheme.labelMedium,
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        setState(() {
                          if (!isSelected) {
                            allLabels.add(selectedLabel);
                          } else {
                            allLabels.remove(selectedLabel);
                          }

                          updatedNote = updatedNote.copyWith(labels: allLabels);
                          _searchController.clear();
                          FocusScope.of(context).unfocus();
                          searchQuery = '';
                        });
                      },
                      icon: Icon(
                        isSelected
                            ? Icons.check_box
                            : Icons.check_box_outline_blank_rounded,
                        color: themeData.iconTheme.color,
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('An error occurred'));
          }
        },
      ),
    );
  }
}
