import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mindwrite/features/label_feature/presentation/bloc/label_bloc.dart';
import 'package:mindwrite/features/label_feature/data/model/label_model.dart';
import 'package:mindwrite/features/label_feature/presentation/widgets/label_builder.dart';

class LabelView extends StatefulWidget {
  const LabelView({super.key});

  @override
  State<LabelView> createState() => _LabelViewState();
}

class _LabelViewState extends State<LabelView> {
  final TextEditingController labelNameTextController = TextEditingController();
  final FocusNode _labelFocusNode = FocusNode();
  String? errorText;
  bool isTyping = false;

  @override
  void initState() {
    super.initState();
    labelNameTextController.addListener(() {
      setState(() {
        isTyping = labelNameTextController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    labelNameTextController.dispose();
    _labelFocusNode.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    context.read<LabelBloc>().add(LoadLabelsEvent());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        labelNameTextController.clear();
        setState(() {
          isTyping = false;
        });
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Edit Labels"),
          leading: IconButton(
            onPressed: () => context.go('/home'),
            icon: const Icon(Icons.arrow_back_rounded),
          ),
        ),
        body: SafeArea(
          child: BlocListener<LabelBloc, LabelState>(
            listener: (context, state) {
              if (state is LabelFailed) {
                setState(() {
                  errorText = state.error;
                });
              } else {
                setState(() {
                  errorText = null;
                });
              }
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Label creation field
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    decoration: BoxDecoration(
                      color: themeData.scaffoldBackgroundColor,
                      border: isTyping
                          ? const Border.symmetric(
                              horizontal:
                                  BorderSide(color: Colors.white24, width: 1),
                            )
                          : null,
                    ),
                    child: ListTile(
                      titleTextStyle: themeData.textTheme.labelMedium,
                      title: TextField(
                        controller: labelNameTextController,
                        focusNode: _labelFocusNode,
                        onTap: () {
                          setState(() {
                            isTyping = true;
                          });
                        },
                        maxLength: 20,
                        style: themeData.textTheme.labelMedium,
                        onSubmitted: (value) {
                          if (value.isNotEmpty) {
                            context.read<LabelBloc>().add(
                                SaveLabelEvent(LabelModel(labelName: value)));

                            if (errorText == null) {
                              _labelFocusNode.unfocus();
                              labelNameTextController.clear();
                              setState(() {
                                isTyping = false;
                              });
                            }
                          }
                        },
                        decoration: InputDecoration(
                          hintText: 'Label Name',
                          errorText: errorText,
                          hintStyle: themeData.textTheme.labelMedium,
                          counterText: "",
                          border: const OutlineInputBorder(
                              borderSide: BorderSide.none),
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide.none),
                          disabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide.none),
                        ),
                      ),
                      leading: isTyping
                          ? IconButton(
                              onPressed: () {
                                _labelFocusNode.unfocus();
                                labelNameTextController.clear();
                                setState(() {
                                  isTyping = false;
                                });
                              },
                              icon: Icon(Icons.clear,
                                  color: themeData.iconTheme.color),
                            )
                          : IconButton(
                              onPressed: () {
                                final newLabel = labelNameTextController.text;
                                if (newLabel.isNotEmpty) {
                                  context.read<LabelBloc>().add(SaveLabelEvent(
                                      LabelModel(labelName: newLabel)));
                                  _labelFocusNode.unfocus();
                                  labelNameTextController.clear();
                                  setState(() {
                                    isTyping = false;
                                  });
                                }
                              },
                              icon: Icon(Icons.add,
                                  color: themeData.iconTheme.color),
                            ),
                      trailing: isTyping
                          ? IconButton(
                              onPressed: () {
                                final newLabel = labelNameTextController.text;
                                if (newLabel.isNotEmpty) {
                                  context.read<LabelBloc>().add(SaveLabelEvent(
                                      LabelModel(labelName: newLabel)));

                                  labelNameTextController.clear();
                                }
                              },
                              icon: Icon(Icons.check_rounded,
                                  color: themeData.iconTheme.color),
                            )
                          : null,
                    ),
                  ),

                  // Unfocus creation field when clicking an item in LabelBuilder
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      labelNameTextController.clear();
                      setState(() {
                        isTyping = false;
                      });
                    },
                    child: LabelBuilder(
                      isLabelCreating: isTyping,
                      labelActionFocus: () {
                        setState(() {
                          isTyping = false;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
