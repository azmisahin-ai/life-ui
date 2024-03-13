// app/app.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui/screen/main_screen.dart';
import 'package:ui/state/providers/theme_provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App',
      theme: Provider.of<ThemeProvider>(context).currentTheme,
      home: const MainScreen(),
    );
  }
}
