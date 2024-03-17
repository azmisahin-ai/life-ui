// features/simulation/options/simulation_particle_card.dart

import 'package:flutter/material.dart';

class SimulationParticleCard extends StatelessWidget {
  final String title;
  final IconData icon;

  const SimulationParticleCard({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: Icon(icon),
      title: Text(title),
      children: [
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Number of particles',
            hintText: 'Enter number of particles',
          ),
          keyboardType: TextInputType.number,
          // Implement any necessary logic for handling input
        ),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Time step',
            hintText: 'Enter cycle rate of main life time',
          ),
          keyboardType: TextInputType.number,
          // Implement any necessary logic for handling input
        ),
      ],
    );
  }
}
