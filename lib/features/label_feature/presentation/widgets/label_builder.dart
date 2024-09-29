import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindwrite/core/widgets/circular_indicator_widget.dart';
import 'package:mindwrite/features/label_feature/data/model/label_model.dart';
import 'package:mindwrite/features/label_feature/presentation/bloc/label_bloc.dart';

class LabelBuilder extends StatefulWidget {
  final VoidCallback labelActionFocus;
  final bool isLabelCreating;

  const LabelBuilder({
    super.key,
    required this.labelActionFocus,
    required this.isLabelCreating,
  });

  @override
  State<LabelBuilder> createState() => _LabelBuilderState();
}

class _LabelBuilderState extends State<LabelBuilder> {
  List<TextEditingController> _controllers = [];
  List<FocusNode> _focusNodes = [];
  String? errorText;
  int? _activeIndex;

  @override
  void dispose() {
    // Dispose of controllers and focus nodes
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _initializeControllersAndFocusNodes(List<LabelModel> labels) {
    // Initialize controllers and focus nodes based on the labels
    _controllers = labels
        .map((label) => TextEditingController(text: label.labelName))
        .toList();

    _focusNodes = List.generate(labels.length, (index) {
      FocusNode node = FocusNode();
      node.addListener(() {
        if (!node.hasFocus && _activeIndex == index) {
          setState(() {
            _activeIndex = null;
          });
        }
      });
      return node;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return GestureDetector(
      onTap: () {
        // Unfocus any active text fields when tapping outside
        FocusScope.of(context).unfocus();
        setState(() {
          _activeIndex = null;
        });
      },
      child: BlocConsumer<LabelBloc, LabelState>(
        listener: (context, state) {
          if (state is LabelInitial) {
            // Initialize controllers and focus nodes once the labels are loaded
            _initializeControllersAndFocusNodes(state.labelList);
          } else if (state is LabelFailed) {
            if (mounted) {
              Future.delayed(const Duration(seconds: 2)).then((value) {
                if (context.mounted) {
                  context.read<LabelBloc>().add(
                        LoadLabelsEvent(),
                      );
                }
              });
            }
            setState(() {
              errorText = state.error;
            });
          } else {
            setState(() {
              errorText = null;
            });
          }
        },
        builder: (context, state) {
          if (state is LabelInitial) {
            if (_controllers.isEmpty) {
              // Initialize controllers and focus nodes
              _initializeControllersAndFocusNodes(state.labelList);
            }

            return ListView.builder(
              itemCount: state.labelList.length,
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                TextEditingController controller = _controllers[index];
                FocusNode focusNode = _focusNodes[index];

                return ListTile(
                  title: TextField(
                    maxLength: 20,
                    controller: controller,
                    focusNode: focusNode,
                    onTap: () {
                      widget.labelActionFocus();
                      FocusScope.of(context).requestFocus(focusNode);
                      setState(() {
                        _activeIndex = index;
                      });
                    },
                    decoration: InputDecoration(
                      errorText: errorText,
                      counterText: "",
                      hintStyle: themeData.textTheme.labelMedium,
                      border: InputBorder.none,
                    ),
                    style: themeData.textTheme.labelMedium,
                  ),
                  leading: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (child, animation) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                    child: _activeIndex == index
                        ? IconButton(
                            key: const ValueKey('clear_icon'),
                            onPressed: () {
                              // Delete label
                              context.read<LabelBloc>().add(DeleteLabelEvent(
                                    LabelModel(
                                        labelName: controller.text,
                                        id: state.labelList[index].id),
                                  ));
                              controller.clear();
                              setState(() {
                                _activeIndex = null;
                              });
                            },
                            icon: Icon(Icons.delete_outline_rounded,
                                color: themeData.iconTheme.color),
                          )
                        : Icon(Icons.label_important_outline_rounded,
                            color: themeData.iconTheme.color),
                  ),
                  trailing: _activeIndex == index
                      ? IconButton(
                          onPressed: () {
                            if (controller.text.isNotEmpty) {
                              // Save edited label
                              context.read<LabelBloc>().add(EditLabelEvent(
                                  LabelModel(
                                      labelName: controller.text,
                                      id: state.labelList[index].id)));
                              setState(() {
                                _activeIndex = null;
                              });
                            }
                          },
                          icon: Icon(Icons.check_rounded,
                              color: themeData.iconTheme.color),
                        )
                      : Icon(Icons.edit, color: themeData.iconTheme.color),
                );
              },
            );
          } else {
            return const CircularIndicatorWidget();
          }
        },
      ),
    );
  }
}
