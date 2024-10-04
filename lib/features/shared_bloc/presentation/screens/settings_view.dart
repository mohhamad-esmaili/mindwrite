import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mindwrite/core/widgets/app_drawer.dart';
import 'package:mindwrite/features/shared_bloc/presentation/bloc/shared_bloc.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    SharedBloc sharedBloc = BlocProvider.of<SharedBloc>(context);
    ThemeData themeData = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title:const Text("Settings"),
      ),
      drawer: const AppDrawer(),
      body: BlocBuilder<SharedBloc, SharedState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                child: Text(
                  "Display options",
                  style: themeData.textTheme.labelLarge,
                ),
              ),
              InkWell(
                onTap: () async {
                  return showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text(
                        "Choose theme",
                        textAlign: TextAlign.start,
                        style: themeData.textTheme.labelLarge,
                      ),
                      backgroundColor: themeData.appBarTheme.backgroundColor,
                      actionsAlignment: MainAxisAlignment.spaceAround,
                      actions: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RadioListTile<ThemeMode>(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              activeColor: themeData.primaryColor,
                              title: Text(
                                'Light Mode',
                                style: themeData.textTheme.labelMedium,
                              ),
                              value: ThemeMode.light,
                              groupValue: state.themeMode,
                              onChanged: (ThemeMode? mode) {
                                if (mode != null) {
                                  sharedBloc.add(ToggleTheme());
                                }
                                context.pop();
                              },
                            ),
                            RadioListTile<ThemeMode>(
                              title: Text(
                                'Dark Mode',
                                style: themeData.textTheme.labelMedium,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              activeColor: themeData.primaryColor,
                              value: ThemeMode.dark,
                              groupValue: state.themeMode,
                              onChanged: (ThemeMode? mode) {
                                if (mode != null) {
                                  sharedBloc.add(ToggleTheme());
                                }
                                context.pop();
                              },
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () => context.pop(),
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 40,
                                  vertical: 20,
                                ),
                                shadowColor: Theme.of(context).primaryColor,
                              ),
                              child: Text(
                                "Cancel",
                                style: TextStyle(
                                    color: themeData.primaryColor,
                                    fontSize: 15),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Theme", style: themeData.textTheme.labelMedium),
                      Text(
                        state.themeMode.name,
                        style: themeData.textTheme.labelMedium,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
