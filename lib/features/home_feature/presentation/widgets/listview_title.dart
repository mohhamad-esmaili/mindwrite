import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ListviewTitle extends StatelessWidget {
  final String title;
  const ListviewTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, top: 10, bottom: 10),
      child: Text(
        title,
        style: const TextStyle(fontSize: 15, color: Colors.white),
      ),
    ).animate().fade(duration: Duration(milliseconds: 300));
  }
}
