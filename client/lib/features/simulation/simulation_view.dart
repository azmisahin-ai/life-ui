// features/simulation/simulation_view.dart

import 'package:flutter/material.dart';
import 'package:ui/features/simulation/simulation_card.dart';

class SimulationView extends StatelessWidget {
  const SimulationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SimulationCard(title: 'Statistics', icon: Icons.show_chart),
          ],
        ),
      ),
    );
  }
}
