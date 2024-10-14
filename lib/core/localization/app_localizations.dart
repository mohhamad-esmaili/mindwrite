import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  Map<String, String> _localizedStrings = {};

  // بارگذاری فایل محلی‌سازی
  Future<bool> load() async {
    String jsonString = await rootBundle
        .loadString('lib/core/localization/app_${locale.languageCode}.arb');
    _localizedStrings = Map.from(json.decode(jsonString));
    return true;
  }

  // متد عمومی برای دسترسی به هر کلید
  String translate(String key) {
    return _localizedStrings[key] ?? key;
  }

  // Getters for all localization keys
  String get no => translate('no');
  String get ok => translate('ok');
  String get yes => translate('yes');
  String get undo => translate('Undo');
  String get edit => translate('edit');
  String get mind => translate('Mind');
  String get send => translate('Send');
  String get couldntload => translate('Couldnt load');
  String get nodrawingdetected => translate('No drawing detected');
  String get write => translate('Write');
  String get title => translate('Title');
  String get theme => translate('Theme');
  String get light => translate('light');
  String get notes => translate('Notes');
  String get notearchived => translate('Note Archived');
  String get searchlabels => translate('Search labels');
  String get anerroroccurred => translate('An error occurred');
  String get areyousure => translate('Are You Sure');
  String get enternotetitle => translate('Enter note title');
  String get pinned => translate('Pinned');
  String get colors => translate('Colors');
  String get others => translate('Others');
  String get labels => translate('Labels');
  String get edited => translate('Edited');
  String get delete => translate('Delete');
  String get cancel => translate('Cancel');
  String get english => translate('English');
  String get persian => translate('Persian');
  String get archive => translate('Archive');
  String get deleted => translate('Deleted');
  String get drawing => translate('Drawing');
  String get language => translate('Language');
  String get settings => translate('Settings');
  String get addImage => translate('Add image');
  String get darkMode => translate('Dark mode');
  String get emptybin => translate('Empty bin');
  String get takePhoto => translate('Take photo');
  String get noteColor => translate('Note Color');
  String get mindWrite => translate('Mind Write');
  String get lightMode => translate('Light mode');
  String get labelName => translate('Label name');
  String get makeACopy => translate('Make a copy');
  String get noteCopied => translate('Note copied');
  String get editLabels => translate('Edit labels');
  String get backgrounds => translate('Backgrounds');
  String get description => translate('Description');
  String get searchNotes => translate('Search notes');
  String get chooseTheme => translate('Choose theme');
  String get alreadyempty => translate('Already empty');
  String get noterestored => translate('Notes restored');
  String get deleteforever => translate('Delete forever');
  String get aboutMindWrite => translate('About MindWrite');
  String get displayOptions => translate('Display options');
  String get chooseLanguage => translate('Choose language');
  String get createNewLabel => translate('Create new label');
  String get thereIsNoNote => translate('There is no note');
  String get aboutAndFeedback => translate('About and feedback');
  String get failedtoloadnotes => translate('Failed to load notes');
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'fa'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
