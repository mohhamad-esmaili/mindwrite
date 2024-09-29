import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mindwrite/core/utils/color_constants.dart';
import 'package:mindwrite/features/label_feature/data/model/label_model.dart';

import 'package:mindwrite/features/label_feature/presentation/bloc/label_bloc.dart';
import 'package:mindwrite/features/shared_bloc/presentation/bloc/shared_bloc.dart';

class AppDrawer extends StatelessWidget {
  final String? selectedLabel;
  const AppDrawer({super.key, this.selectedLabel});

  @override
  Widget build(BuildContext context) {
    final currentPathName = GoRouterState.of(context).path;
    final SharedBloc sharedBloc = BlocProvider.of<SharedBloc>(context);
    BlocProvider.of<LabelBloc>(context).add(LoadLabelsEvent());
    ThemeData themeData = Theme.of(context);
    return Drawer(
      child: Scrollbar(
        child: SafeArea(
          child: ListView(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: [
                      TextSpan(
                        text: 'Mind ',
                        style: TextStyle(
                            color: themeData.textTheme.titleMedium!.color,
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      ),
                      TextSpan(
                        text: 'Write',
                        style: TextStyle(
                            color: themeData.textTheme.titleMedium!.color,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                    ],
                  ),
                ),
              ),
              makeTextButton(
                context: context,
                title: "Notes",
                onpress: () {
                  ScaffoldMessenger.of(context).clearSnackBars();
                  sharedBloc.add(ExitSelectionMode());
                  context.go('/home');
                },
                buttonIcon: Icons.lightbulb_outline_rounded,
                currentPathName: currentPathName!,
                buttonPath: '/home',
              ),
              Divider(
                color: AppColorConstants.drawerDividerColor,
                thickness: 2,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Labels",
                      style: themeData.textTheme.titleMedium,
                    ),
                    TextButton(
                      onPressed: () => context.go("/label"),
                      child: Text(
                        "edit",
                        style: themeData.textTheme.titleMedium,
                      ),
                    )
                  ],
                ),
              ),
              BlocBuilder<LabelBloc, LabelState>(
                builder: (context, state) {
                  if (state is LabelInitial) {
                    return ListView.builder(
                      itemCount: state.labelList.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        final label = state.labelList[index];
                        return makeTextButton(
                          context: context,
                          title: label.labelName,
                          onpress: () =>
                              context.go('/label_category', extra: label),
                          buttonIcon: Icons.label_outline_rounded,
                          currentPathName: label.labelName,
                          buttonPath: "/label_category",
                          selectedLabel: label,
                          labelPath: selectedLabel,
                        );
                      },
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
              makeTextButton(
                context: context,
                title: "Create new label",
                onpress: () {
                  ScaffoldMessenger.of(context).clearSnackBars();
                  sharedBloc.add(ExitSelectionMode());
                  context.go('/label');
                },
                buttonIcon: Icons.add,
                currentPathName: currentPathName,
                buttonPath: '/label',
              ),
              Divider(
                color: AppColorConstants.drawerDividerColor,
                thickness: 2,
              ),
              makeTextButton(
                context: context,
                title: "Archive",
                onpress: () {
                  ScaffoldMessenger.of(context).clearSnackBars();
                  sharedBloc.add(ExitSelectionMode());
                  context.go('/archive');
                },
                buttonIcon: Icons.archive_outlined,
                currentPathName: currentPathName,
                buttonPath: '/archive',
              ),
              makeTextButton(
                context: context,
                title: "Deleted",
                onpress: () {
                  ScaffoldMessenger.of(context).clearSnackBars();
                  sharedBloc.add(ExitSelectionMode());
                  context.go('/delete');
                },
                buttonIcon: Icons.delete_outline_rounded,
                currentPathName: currentPathName,
                buttonPath: '/delete',
              ),
              makeTextButton(
                context: context,
                title: "Settings",
                onpress: () {
                  context.go('/setting');
                },
                buttonIcon: Icons.settings,
                currentPathName: currentPathName,
                buttonPath: '/setting',
              ),
              makeTextButton(
                context: context,
                title: "About & feedback",
                onpress: () {
                  context.go('/about');
                },
                buttonIcon: Icons.info_outlined,
                currentPathName: currentPathName,
                buttonPath: '/about',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget makeTextButton({
    required BuildContext context,
    required String title,
    required VoidCallback onpress,
    required IconData buttonIcon,
    required String currentPathName,
    required String buttonPath,
    LabelModel? selectedLabel,
    String? labelPath,
  }) {
    bool isSelected = currentPathName == buttonPath ||
        (selectedLabel != null && labelPath == currentPathName);
    return TextButton.icon(
      onPressed: () {
        ScaffoldMessenger.of(context).clearSnackBars();
        onpress();
        context.pop();
      },
      icon: Icon(
        buttonIcon,
        color: isSelected
            ? AppColorConstants.whiteTextColor
            : Theme.of(context).iconTheme.color,
      ),
      label: Text(
        title,
        style: isSelected
            ? TextStyle(color: AppColorConstants.whiteTextColor, fontSize: 15)
            : Theme.of(context).textTheme.titleMedium,
      ),
      style: TextButton.styleFrom(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
        backgroundColor:
            isSelected ? Theme.of(context).primaryColor : Colors.transparent,
      ),
    );
  }
}
