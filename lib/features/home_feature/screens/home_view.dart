import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        height: 75,
        width: 75,
        margin: EdgeInsets.only(bottom: 10),
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Color.fromRGBO(41, 42, 44, 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(
            Icons.add,
            size: 55,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
      bottomNavigationBar: BottomAppBar(
        // height: 60,
        color: Colors.amber,
        notchMargin: 8.5,
        padding: EdgeInsets.all(10),

        shape: const CircularNotchedRectangle(),
        clipBehavior: Clip.none,
        child: Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.check_box_outlined,
                size: 40,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.brush_rounded,
                size: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
