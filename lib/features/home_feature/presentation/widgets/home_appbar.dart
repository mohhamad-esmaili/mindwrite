import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mindwrite/core/utils/color_constants.dart';
import 'package:mindwrite/features/home_feature/presentation/bloc/home_bloc.dart';

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
  void initState() {
    super.initState();
    if (widget.isLoading) {
      setState(() {
        showLoader = true;
      });

      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            showLoader = false;
          });
        }
      });
    }
  }

  @override
  void didUpdateWidget(covariant TemporaryLoadingIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Reset the loader if isLoading state changes
    if (widget.isLoading && !oldWidget.isLoading) {
      setState(() {
        showLoader = true;
      });
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) {
          setState(() {
            showLoader = false;
          });
        }
      });
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
              key: ValueKey<bool>(false), // Unique key for the text widget
            ),
    );
  }
}

class SliverHomeAppbar extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const SliverHomeAppbar({super.key, required this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        bool isLoading = state is HomeLoading;

        return SliverAppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          foregroundColor: Colors.transparent,
          title: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: AppColorConstants.appbarDarkColor,
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => scaffoldKey.currentState!.openDrawer(),
                  icon: Icon(
                    Icons.menu,
                    color: themeData.iconTheme.color,
                  ),
                ),
                TemporaryLoadingIndicator(isLoading: isLoading),
              ],
            ),
          ),
        );
      },
    );
  }
}
