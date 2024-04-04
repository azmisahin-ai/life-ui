// features/simulation/simulation_card.dart

import 'package:flutter/material.dart';
import 'package:ui/repository/simulation_repository.dart';
import 'package:ui/features/simulation/cards/simulation_particle_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SimulationCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final SimulationRepository simulationRepository;

  const SimulationCard(
      {super.key,
      required this.title,
      required this.icon,
      required this.simulationRepository});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        ListTile(
          leading: Icon(icon),
          title: Text(title),
          onTap: () {},
        ),
        SimulationParticleCard(
          title: AppLocalizations.of(context)!.simulation_particle_title,
          icon: Icons.show_chart,
          simulationRepository: simulationRepository,
        )
      ],
    );
  }
}
