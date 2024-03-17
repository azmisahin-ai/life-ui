import 'package:flutter/material.dart';
import 'package:ui/features/simulation/simulation_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SimulationView extends StatelessWidget {
  const SimulationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.simulation_title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SimulationCard(
                title: AppLocalizations.of(context)!.settings_card_title,
                icon: Icons.show_chart,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: SimulationCard(
                title: AppLocalizations.of(context)!.settings_card_title,
                icon: Icons.show_chart,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
