import 'package:flutter/material.dart';
import 'package:mindwrite/core/localization/app_localizations.dart';
import 'package:mindwrite/core/widgets/app_drawer.dart';
import 'package:mindwrite/core/widgets/snackbar_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.aboutAndFeedback),
      ),
      drawer: const AppDrawer(),
      body: Directionality(
        textDirection: TextDirection.ltr,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Made with ", style: themeData.textTheme.labelLarge),
                const Icon(Icons.favorite, color: Colors.red),
                Text(" in Flutter", style: themeData.textTheme.labelLarge),
              ],
            ),
            InkWell(
              onTap: () => _launchURL(context),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Give project ",
                        style: themeData.textTheme.labelLarge),
                    Icon(Icons.star, color: Colors.yellow[700]),
                    Text(" in github", style: themeData.textTheme.labelLarge),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _launchURL(BuildContext context) async {
    final Uri url = Uri.parse('https://github.com/mohhamad-esmaili/mindwrite');
    if (!await launchUrl(url) && context.mounted) {
      SnackbarService.showStatusSnackbar(
          message: AppLocalizations.of(context)!.couldntload, context: context);
    }
  }
}
