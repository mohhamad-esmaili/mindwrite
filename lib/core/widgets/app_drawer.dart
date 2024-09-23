import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mindwrite/core/utils/color_constants.dart';
import 'package:mindwrite/features/shared_bloc/presentation/bloc/shared_bloc.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final currentPathName = GoRouterState.of(context).path;
    final SharedBloc sharedBloc = BlocProvider.of<SharedBloc>(context);
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
                            color: AppColorConstants.primaryDarkColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      ),
                      TextSpan(
                        text: 'Write',
                        style: TextStyle(
                            color: AppColorConstants.primaryDarkColor,
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
                  buttonPath: '/home'),
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
                      style: TextStyle(
                          color: AppColorConstants.darkerWhiteTextColor,
                          fontSize: 15),
                    ),
                    TextButton(
                      onPressed: () => context.go("/label"),
                      child: Text(
                        "edit",
                        style: TextStyle(
                            color: AppColorConstants.darkerWhiteTextColor,
                            fontSize: 15),
                      ),
                    )
                  ],
                ),
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
            ],
          ),
        ),
      ),
    );
  }

  Widget makeTextButton(
          {required BuildContext context,
          required String title,
          required VoidCallback onpress,
          required IconData buttonIcon,
          required String currentPathName,
          required String buttonPath}) =>
      TextButton.icon(
        onPressed: onpress,
        icon: Icon(
          buttonIcon,
          color: Theme.of(context).iconTheme.color,
        ),
        label: Text(
          title,
          style: TextStyle(
              color: AppColorConstants.darkerWhiteTextColor, fontSize: 15),
        ),
        style: TextButton.styleFrom(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
          backgroundColor: currentPathName == buttonPath
              ? Theme.of(context).primaryColor
              : Colors.transparent,
        ),
      );
}
