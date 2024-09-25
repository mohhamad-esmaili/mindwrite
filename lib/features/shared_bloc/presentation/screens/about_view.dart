import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindwrite/core/widgets/app_drawer.dart';
import 'package:mindwrite/core/widgets/screens_appbar.dart';
import 'package:mindwrite/features/shared_bloc/presentation/bloc/shared_bloc.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    SharedBloc sharedBloc = BlocProvider.of(context);
    return Scaffold(
      appBar: ScreensAppbar(
        appbarTitle: "About MindWrite",
        sharedBloc: sharedBloc,
      ),
      drawer: const AppDrawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Made with ", style: TextStyle(color: Colors.white)),
              Icon(Icons.favorite, color: Colors.red),
              Text(" in Flutter", style: TextStyle(color: Colors.white)),
            ],
          )
        ],
      ),
    );
  }
}
