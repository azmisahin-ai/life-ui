// features/simulation/simulation_result_card.dart

import 'package:flutter/material.dart';

class SimulationResultCard extends StatelessWidget {
  final String title;
  final IconData icon;

  const SimulationResultCard(
      {super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        title,
      ),
      onTap: () {},
    );
  }
}
