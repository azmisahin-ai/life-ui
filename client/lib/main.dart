// main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui/app/app.dart';
import 'package:ui/state/providers/theme_provider.dart';

void main() async {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const App(),
    ),
  );
}
