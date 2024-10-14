import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mindwrite/core/localization/app_localizations.dart';
import 'package:mindwrite/core/utils/color_constants.dart';
import 'package:mindwrite/features/label_feature/data/model/label_model.dart';
import 'package:mindwrite/features/label_feature/presentation/bloc/label_bloc.dart';
import 'package:mindwrite/features/shared_bloc/presentation/bloc/shared_bloc.dart';

class AppDrawer extends StatelessWidget {
  final String? selectedLabel;
  const AppDrawer({super.key, this.selectedLabel});

  @override
  Widget build(BuildContext context) {
    final currentPathName = GoRouterState.of(context).path;
    final SharedBloc sharedBloc = BlocProvider.of<SharedBloc>(context);
    BlocProvider.of<LabelBloc>(context).add(LoadLabelsEvent());
    ThemeData themeData = Theme.of(context);
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    bool isRTL = Localizations.localeOf(context).languageCode == 'fa';

    return Directionality(
      textDirection: isRTL
          ? TextDirection.rtl
          : TextDirection.ltr, // تنظیم جهت بر اساس زبان
      child: Drawer(
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
                          text: appLocalizations.mind,
                          style: TextStyle(
                              color: themeData.textTheme.titleMedium!.color,
                              fontWeight: FontWeight.bold,
                              fontSize: 30),
                        ),
                        TextSpan(
                          text: appLocalizations.write,
                          style: TextStyle(
                              color: themeData.textTheme.titleMedium!.color,
                              fontWeight: FontWeight.bold,
                              fontSize: 25),
                        ),
                      ],
                    ),
                  ),
                ),
                makeTextButton(
                  context: context,
                  isRTL: isRTL,
                  title: appLocalizations.notes,
                  onpress: () {
                    ScaffoldMessenger.of(context).clearSnackBars();
                    sharedBloc.add(ExitSelectionMode());
                    context.go('/home');
                  },
                  buttonIcon: Icons.lightbulb_outline_rounded,
                  currentPathName: currentPathName!,
                  buttonPath: '/home',
                ),
                Divider(
                  color: AppColorConstants.drawerDividerColor,
                  thickness: 2,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        appLocalizations.labels,
                        style: themeData.textTheme.titleMedium,
                      ),
                      TextButton(
                        onPressed: () => context.go("/label"),
                        child: Text(
                          appLocalizations.edit,
                          style: themeData.textTheme.titleMedium,
                        ),
                      )
                    ],
                  ),
                ),
                BlocBuilder<LabelBloc, LabelState>(
                  builder: (context, state) {
                    if (state is LabelInitial) {
                      return ListView.builder(
                        itemCount: state.labelList.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          final label = state.labelList[index];
                          return makeTextButton(
                            context: context,
                            isRTL: isRTL,
                            title: label.labelName,
                            onpress: () =>
                                context.go('/label_category', extra: label),
                            buttonIcon: Icons.label_outline_rounded,
                            currentPathName: label.labelName,
                            buttonPath: "/label_category",
                            selectedLabel: label,
                            labelPath: selectedLabel,
                          );
                        },
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
                makeTextButton(
                  context: context,
                  isRTL: isRTL,
                  title: appLocalizations.createNewLabel,
                  onpress: () {
                    ScaffoldMessenger.of(context).clearSnackBars();
                    sharedBloc.add(ExitSelectionMode());
                    context.go('/label');
                  },
                  buttonIcon: Icons.add,
                  currentPathName: currentPathName,
                  buttonPath: '/label',
                ),
                Divider(
                  color: AppColorConstants.drawerDividerColor,
                  thickness: 2,
                ),
                makeTextButton(
                  context: context,
                  isRTL: isRTL,
                  title: appLocalizations.archive,
                  onpress: () {
                    ScaffoldMessenger.of(context).clearSnackBars();
                    sharedBloc.add(ExitSelectionMode());
                    context.go('/archive');
                  },
                  buttonIcon: Icons.archive_outlined,
                  currentPathName: currentPathName,
                  buttonPath: '/archive',
                ),
                makeTextButton(
                  context: context,
                  isRTL: isRTL,
                  title: appLocalizations.deleted,
                  onpress: () {
                    ScaffoldMessenger.of(context).clearSnackBars();
                    sharedBloc.add(ExitSelectionMode());
                    context.go('/delete');
                  },
                  buttonIcon: Icons.delete_outline_rounded,
                  currentPathName: currentPathName,
                  buttonPath: '/delete',
                ),
                makeTextButton(
                  context: context,
                  isRTL: isRTL,
                  title: appLocalizations.settings,
                  onpress: () {
                    context.go('/setting');
                  },
                  buttonIcon: Icons.settings,
                  currentPathName: currentPathName,
                  buttonPath: '/setting',
                ),
                makeTextButton(
                  context: context,
                  isRTL: isRTL,
                  title: appLocalizations.aboutAndFeedback,
                  onpress: () {
                    context.go('/about');
                  },
                  buttonIcon: Icons.info_outlined,
                  currentPathName: currentPathName,
                  buttonPath: '/about',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget makeTextButton({
    required BuildContext context,
    required bool isRTL,
    required String title,
    required VoidCallback onpress,
    required IconData buttonIcon,
    required String currentPathName,
    required String buttonPath,
    LabelModel? selectedLabel,
    String? labelPath,
  }) {
    bool isSelected = currentPathName == buttonPath ||
        (selectedLabel != null && labelPath == currentPathName);
    return TextButton.icon(
      onPressed: () {
        ScaffoldMessenger.of(context).clearSnackBars();
        onpress();
        context.pop();
      },
      icon: Icon(
        buttonIcon,
        color: isSelected
            ? AppColorConstants.whiteTextColor
            : Theme.of(context).iconTheme.color,
      ),
      label: Text(
        title,
        style: isSelected
            ? TextStyle(color: AppColorConstants.whiteTextColor, fontSize: 15)
            : Theme.of(context).textTheme.titleMedium,
      ),
      style: TextButton.styleFrom(
        alignment: isRTL ? Alignment.centerRight : Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
        backgroundColor:
            isSelected ? Theme.of(context).primaryColor : Colors.transparent,
      ),
    );
  }
}
