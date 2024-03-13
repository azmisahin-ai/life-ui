// features/settings_view/settings_view.dart
import 'package:flutter/material.dart';
import 'package:ui/features/settings/settings_card.dart';
import 'package:provider/provider.dart';
import 'package:ui/state/providers/theme_provider.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SettingsCard(
              title: 'Change Theme',
              icon: Icons.change_circle,
              onTap: () {
                _showThemeSelectionDialog(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showThemeSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Theme'),
          content: Column(
            children: [
              ListTile(
                title: Text('Light Theme'),
                onTap: () {
                  Provider.of<ThemeProvider>(context, listen: false)
                      .setTheme(ThemeData.light());
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Dark Theme'),
                onTap: () {
                  Provider.of<ThemeProvider>(context, listen: false)
                      .setTheme(ThemeData.dark());
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
