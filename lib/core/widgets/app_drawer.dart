import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mindwrite/core/utils/color_constants.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final currentPathName = GoRouterState.of(context).path;

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
                            color: ColorConstants.primaryDarkColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      ),
                      TextSpan(
                        text: 'Write',
                        style: TextStyle(
                            color: ColorConstants.primaryDarkColor,
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
                  onpress: () => context.go('/'),
                  buttonIcon: Icons.lightbulb_outline_rounded,
                  currentPathName: currentPathName!,
                  buttonPath: '/'),
              Divider(
                color: ColorConstants.drawerDividerColor,
                thickness: 2,
              ),
              makeTextButton(
                  context: context,
                  title: "Archive",
                  onpress: () => context.go('/archive'),
                  buttonIcon: Icons.archive_outlined,
                  currentPathName: currentPathName,
                  buttonPath: '/archive'),
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
              color: ColorConstants.darkerWhiteTextColor, fontSize: 15),
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
