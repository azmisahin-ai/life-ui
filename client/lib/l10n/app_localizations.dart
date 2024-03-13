// lib/l10n/app_localizations.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppLocalizations {
  static Future<AppLocalizations> load(Locale locale) async {
    final String name =
        (locale.countryCode == null || locale.countryCode!.isEmpty)
            ? locale.languageCode
            : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    await initializeMessages(localeName);

    Intl.defaultLocale = localeName;

    return AppLocalizations();
  }

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations) ??
        AppLocalizations();
  }

  String get dashboardTitle =>
      Intl.message('Dashboard', name: 'dashboardTitle');
  String get dataProcessingTitle =>
      Intl.message('Data Processing', name: 'dataProcessingTitle');
  String get analysisTitle => Intl.message('Analysis', name: 'analysisTitle');
  String get learningModelTitle =>
      Intl.message('Learning Model', name: 'learningModelTitle');
  String get simulationTitle =>
      Intl.message('Simulation', name: 'simulationTitle');
  String get evaluationTitle =>
      Intl.message('Evaluation', name: 'evaluationTitle');
  String get settingsTitle => Intl.message('Settings', name: 'settingsTitle');
  String get appTitle => Intl.message('App', name: 'appTitle');

  String translate(String key) {
    return Intl.message(key);
  }

  static initializeMessages(String localeName) {}
}
