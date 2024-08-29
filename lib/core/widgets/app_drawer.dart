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
                context,
                "Notes",
                () => context.go('/'),
                currentPathName == '/'
                    ? Theme.of(context).primaryColor
                    : Colors.transparent,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget makeTextButton(BuildContext context, String title,
          VoidCallback onpress, Color backColor) =>
      TextButton.icon(
        onPressed: onpress,
        icon: Icon(
          Icons.lightbulb_outline_rounded,
          color: Theme.of(context).iconTheme.color,
        ),
        label: Text(
          title,
          style: TextStyle(
              color: ColorConstants.DarkerWhiteTextColor, fontSize: 15),
        ),
        style: TextButton.styleFrom(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 13),
          backgroundColor: backColor,
        ),
      );
}
