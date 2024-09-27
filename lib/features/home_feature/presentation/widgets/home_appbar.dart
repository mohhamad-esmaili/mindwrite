import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mindwrite/core/enums/listmode_enum.dart';
import 'package:mindwrite/core/utils/color_constants.dart';
import 'package:mindwrite/core/widgets/pop_menu_widget.dart';
import 'package:mindwrite/core/widgets/snackbar_widget.dart';
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
                  color: sharedState.themeMode == ThemeMode.light
                      ? AppColorConstants.appbarLightColor
                      : AppColorConstants.appbarDarkColor,
                ),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: sharedBloc.isSelectionMode
                      ? _buildSelectionModeRow(themeData, context)
                      : _buildNormalModeRow(themeData, isLoading, context),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildSelectionModeRow(ThemeData themeData, BuildContext context) {
    return Row(
      key: const ValueKey("delete_mode"),
      children: [
        IconButton(
          onPressed: () => sharedBloc.add(ExitSelectionMode()),
          icon: Icon(Icons.clear, color: themeData.iconTheme.color),
        ),
        Text(
          sharedBloc.selectedItems.length.toString(),
          style: themeData.textTheme.labelMedium,
        ),
        const Spacer(),
        IconButton(
          onPressed: () =>
              sharedBloc.add(PinNotesEvent(sharedBloc.selectedItems)),
          icon: Icon(Icons.push_pin_rounded, color: themeData.iconTheme.color),
        ),
        IconButton(
          onPressed: () =>
              SnackbarService.showPaletteSelector(context: context),
          icon: Icon(Icons.palette_outlined, color: themeData.iconTheme.color),
        ),
        PopMenuWidget().buildPopupMenu(context, sharedBloc),
      ],
    );
  }

  Widget _buildNormalModeRow(
      ThemeData themeData, bool isLoading, BuildContext context) {
    return Row(
      key: const ValueKey("normal"),
      children: [
        IconButton(
          onPressed: () => scaffoldKey.currentState!.openDrawer(),
          icon: Icon(Icons.menu, color: themeData.iconTheme.color),
        ),
        TemporaryLoadingIndicator(
          isLoading: isLoading,
          themeData: themeData,
        ),
        const SizedBox(
          width: 200,
          child: SearchTextField(),
        ),
        const Spacer(),
        IconButton(
          onPressed: () => sharedBloc.add(const ChangeCrossAxisCountEvent()),
          icon: Icon(
            sharedBloc.listMode == ListModeEnum.single
                ? Icons.auto_awesome_mosaic_rounded
                : Icons.splitscreen_rounded,
            color: themeData.iconTheme.color,
          ),
        ),
      ],
    );
  }
}

class TemporaryLoadingIndicator extends StatelessWidget {
  final ThemeData themeData;
  final bool isLoading;
  const TemporaryLoadingIndicator(
      {super.key, required this.themeData, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: isLoading
            ? Row(
                key: const ValueKey<bool>(true),
                children: [
                  LoadingAnimationWidget.staggeredDotsWave(
                    color: themeData.appBarTheme.iconTheme!.color!,
                    size: 30,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "Mind write",
                    style: themeData.textTheme.labelMedium,
                  ),
                ],
              )
            : const SizedBox.shrink());
  }
}

class SearchTextField extends StatefulWidget {
  const SearchTextField({super.key});

  @override
  SearchTextFieldState createState() => SearchTextFieldState();
}

class SearchTextFieldState extends State<SearchTextField> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchController.addListener(() {
      context.read<HomeBloc>().add(SearchNotesEvent(_searchController.text));
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return TextField(
      controller: _searchController,
      textDirection: TextDirection.ltr,
      decoration: InputDecoration(
        hintText: "Search your notes",
        hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: themeData.textTheme.labelMedium!.fontSize),
        border: InputBorder.none,
      ),
      style: themeData.textTheme.labelMedium,
      cursorColor: Colors.white,
    ).animate().fade(duration: const Duration(milliseconds: 300));
  }
}
