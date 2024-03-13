// features/dashboard/dashboard_view.dart

import 'package:flutter/material.dart';
import 'package:ui/features/dashboard/dashboard_card.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

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
            DashboardCard(title: 'Statistics', icon: Icons.show_chart),
          ],
        ),
      ),
    );
  }
}
