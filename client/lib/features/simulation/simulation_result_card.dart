// features/simulation/simulation_result_card.dart

import 'package:flutter/material.dart';
import 'package:ui/features/simulation/simulation_result.dart';

class SimulationResultCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Future<SimulationResult>? simulationResult;

  const SimulationResultCard({
    Key? key,
    required this.title,
    required this.icon,
    this.simulationResult,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SimulationResult>(
      future: simulationResult,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final result = snapshot.data;

          // Yeni veri geldiğinde bileşeni güncellemek için
          // bu noktada result değişkenini kullanabilirsiniz
          // Örnek olarak:
          // final newResult = result!.updatedData();
          // veya setState kullanarak değişiklik yapabilirsiniz.

          return ListTile(
            leading: Icon(icon),
            title: Text(title),
            subtitle: Text(result != null ? result.status : 'No result'),
            onTap: () {},
          );
        }
      },
    );
  }
}
