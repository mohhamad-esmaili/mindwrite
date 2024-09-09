import 'package:flutter/material.dart';
import 'package:mindwrite/core/utils/color_constants.dart';

class HomeBottomBar extends StatelessWidget {
  const HomeBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: ColorConstants.appbarDarkColor,
      notchMargin: 10,
      padding: EdgeInsets.all(5),
      shape: const CircularNotchedRectangle(),
      clipBehavior: Clip.antiAlias,
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.check_box_outlined,
              size: 35,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.brush_rounded,
              size: 35,
            ),
          ),
        ],
      ),
    );
  }
}
