// features/settings_view/settings_view.dart
import 'package:flutter/material.dart';
import 'package:ui/features/settings/settings_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settings_title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SettingsCard(
              title: AppLocalizations.of(context)!.settings_card_title,
              icon: Icons.change_circle,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
