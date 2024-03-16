// app/app.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui/screen/main_screen.dart';
import 'package:ui/state/providers/theme_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (context) => AppLocalizations.of(context)!.title,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        AppLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      theme: Provider.of<ThemeProvider>(context).currentTheme,
      home: const MainScreen(),
    );
  }
}
