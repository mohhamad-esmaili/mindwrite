import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mindwrite/core/utils/color_constants.dart';
import 'package:mindwrite/features/home_feature/presentation/bloc/home_bloc.dart';
import 'package:mindwrite/features/shared_bloc/presentation/bloc/shared_bloc.dart';

class SliverHomeAppbar extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final SharedBloc sharedBloc;

  const SliverHomeAppbar({
    super.key,
    required this.scaffoldKey,
    required this.sharedBloc,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        bool isLoading = state is HomeLoading;

        return BlocBuilder<SharedBloc, SharedState>(
            bloc: sharedBloc,
            builder: (context, sharedState) {
              return SliverAppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.transparent,
                title: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: double.infinity,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: sharedBloc.isSelectionMode
                        ? BorderRadius.circular(10)
                        : BorderRadius.circular(100),
                    color: AppColorConstants.appbarDarkColor,
                  ),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: sharedBloc.isSelectionMode
                        ? Row(
                            key: const ValueKey("delete_mode"),
                            children: [
                              IconButton(
                                onPressed: () => sharedBloc.add(
                                  DeleteNoteEvent(sharedBloc.selectedItems),
                                ),
                                icon: Icon(
                                  Icons.clear,
                                  color: themeData.iconTheme.color,
                                ),
                              ),
                              Text(sharedBloc.selectedItems.length.toString()),
                              Spacer(),
                              IconButton(
                                onPressed: () => sharedBloc.add(
                                  DeleteNoteEvent(sharedBloc.selectedItems),
                                ),
                                icon: Icon(
                                  Icons.delete_rounded,
                                  color: themeData.iconTheme.color,
                                ),
                              ),
                              IconButton(
                                onPressed: () => sharedBloc.add(
                                  PinNotesEvent(sharedBloc.selectedItems),
                                ),
                                icon: Icon(
                                  Icons.push_pin_rounded,
                                  color: themeData.iconTheme.color,
                                ),
                              ),
                            ],
                          )
                        : Row(
                            key: const ValueKey("normal"),
                            children: [
                              IconButton(
                                onPressed: () =>
                                    scaffoldKey.currentState!.openDrawer(),
                                icon: Icon(
                                  Icons.menu,
                                  color: themeData.iconTheme.color,
                                ),
                              ),
                              TemporaryLoadingIndicator(isLoading: isLoading),
                            ],
                          ),
                  ),
                ),
              );
            });
      },
    );
  }
}

class TemporaryLoadingIndicator extends StatefulWidget {
  final bool isLoading;

  const TemporaryLoadingIndicator({super.key, required this.isLoading});

  @override
  TemporaryLoadingIndicatorState createState() =>
      TemporaryLoadingIndicatorState();
}

class TemporaryLoadingIndicatorState extends State<TemporaryLoadingIndicator> {
  bool showLoader = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateLoaderState();
  }

  @override
  void didUpdateWidget(covariant TemporaryLoadingIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateLoaderState();
  }

  void _updateLoaderState() {
    if (widget.isLoading != showLoader) {
      setState(() {
        showLoader = widget.isLoading;
      });

      if (widget.isLoading) {
        Future.delayed(const Duration(seconds: 3), () {
          if (mounted) {
            setState(() {
              showLoader = false;
            });
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: showLoader
          ? Row(
              key: const ValueKey<bool>(true),
              children: [
                LoadingAnimationWidget.staggeredDotsWave(
                  color: Theme.of(context).appBarTheme.iconTheme!.color!,
                  size: 30,
                ),
                const SizedBox(width: 10),
                const Text("Mind write"),
              ],
            )
          : const Text(
              "Search your notes",
              key: ValueKey<bool>(false),
            ),
    );
  }
}
