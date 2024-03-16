// features/settings/settings_card.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui/state/providers/theme_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final void Function()? onTap;

  const SettingsCard({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        _showThemeSelectionDialog(context);
      },
    );
  }

  void _showThemeSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.settings_select_theme),
          content: Column(
            children: [
              ListTile(
                title: Text(AppLocalizations.of(context)!.settings_light_theme),
                onTap: () {
                  Provider.of<ThemeProvider>(context, listen: false)
                      .setTheme(ThemeData.light());
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text(AppLocalizations.of(context)!.settings_dark_theme),
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
