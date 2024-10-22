import 'package:flutter/material.dart';
import 'package:mindwrite/core/localization/app_localizations.dart';
import 'package:mindwrite/core/utils/color_constants.dart';
import 'package:mindwrite/core/widgets/app_drawer.dart';
import 'package:mindwrite/core/widgets/snackbar_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    String packageName = "com.example.mindwrite";
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.aboutAndFeedback),
      ),
      drawer: const AppDrawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("${appLocalizations.madewith} ",
                  style: themeData.textTheme.labelLarge),
              const Icon(Icons.favorite, color: Colors.red),
              Text(" ${appLocalizations.influtter}",
                  style: themeData.textTheme.labelLarge),
            ],
          ),
          const SizedBox(height: 5),
          InkWell(
            onTap: () => _launchURL(
              context,
              'bazaar://details?id=$packageName',
              'https://cafebazaar.ir/app/$packageName',
            ),
            child: Container(
              color: AppColorConstants.primaryDarkColor.withOpacity(0.5),
              margin: const EdgeInsets.symmetric(vertical: 2),
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("${appLocalizations.rateApp} ",
                      style: themeData.textTheme.labelLarge),
                  Icon(Icons.handshake_outlined, color: Colors.blueAccent[700]),
                  Text(" ${appLocalizations.bazaar}",
                      style: themeData.textTheme.labelLarge),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () => _launchURL(
                context, 'https://github.com/mohhamad-esmaili/mindwrite'),
            child: Container(
              color: AppColorConstants.primaryDarkColor.withOpacity(0.5),
              margin: const EdgeInsets.symmetric(vertical: 2),
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("${appLocalizations.followandgive} ",
                      style: themeData.textTheme.labelLarge),
                  Icon(Icons.star, color: Colors.yellow[700]),
                  Text(" ${appLocalizations.projectingithub}",
                      style: themeData.textTheme.labelLarge),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              final parameters = <String, String>{
                'subject': 'MindWrite feedback',
                'body': 'Thanks for your app 💖',
              };
              final Uri emailLaunchUri = Uri(
                scheme: 'mailto',
                path: 'esmaili.mohhamad@gmail.com',
                query: parameters.entries
                    .map((e) =>
                        '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                    .join('&'),
              );
              try {
                await launchUrl(emailLaunchUri);
              } catch (e) {
                if (context.mounted) {
                  SnackbarService.showStatusSnackbar(
                      message: AppLocalizations.of(context)!.couldntload,
                      context: context);
                }
              }
            },
            child: Container(
              color: AppColorConstants.primaryDarkColor.withOpacity(0.5),
              margin: const EdgeInsets.symmetric(vertical: 2),
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("${appLocalizations.contact} ",
                      style: themeData.textTheme.labelLarge),
                  Icon(Icons.support, color: Colors.deepOrangeAccent[700]),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> _launchURL(BuildContext context, String? selectedUrl,
      [String? fallbackUrl]) async {
    final Uri url = Uri.parse(selectedUrl!);

    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else if (fallbackUrl != null &&
        await canLaunchUrl(Uri.parse(fallbackUrl))) {
      await launchUrl(Uri.parse(fallbackUrl));
    } else if (context.mounted) {
      SnackbarService.showStatusSnackbar(
          message: AppLocalizations.of(context)!.couldntload, context: context);
    }
  }
}
