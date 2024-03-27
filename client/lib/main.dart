// main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui/state/providers/theme_provider.dart';
// import 'package:ui/app/app.dart';
// import 'package:ui/mvp.dart';
import 'package:ui/simulation.dart';

void main() async {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: MyApp(),
    ),
  );
}
