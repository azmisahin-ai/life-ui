// features/simulation/simulation_card.dart

import 'package:flutter/material.dart';
import 'package:ui/services/api_service.dart';
import 'package:ui/features/simulation/options/simulation_particle_card.dart';

class SimulationCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final ApiService apiService;

  const SimulationCard(
      {super.key,
      required this.title,
      required this.icon,
      required this.apiService});

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
          title: "Particle",
          icon: Icons.show_chart,
          apiService: apiService,
        )
      ],
    );
  }
}
