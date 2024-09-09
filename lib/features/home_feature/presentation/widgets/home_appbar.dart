import 'package:flutter/material.dart';
import 'package:mindwrite/core/utils/color_constants.dart';

class SliverHomeAppbar extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const SliverHomeAppbar({super.key, required this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      foregroundColor: Colors.transparent,
      title: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: ColorConstants.appbarDarkColor,
        ),
        child: Row(
          children: [
            IconButton(
                onPressed: () => scaffoldKey.currentState!.openDrawer(),
                icon: Icon(
                  Icons.menu,
                  color: Theme.of(context).iconTheme.color,
                )),
            const Text("Search"),
          ],
        ),
      ),
    );
  }
}
