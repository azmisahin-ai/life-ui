// features/dashboard/dashboard_card.dart

import 'package:flutter/material.dart';

class DashboardCard extends StatelessWidget {
  final String title;
  final IconData icon;

  const DashboardCard({super.key, required this.title, required this.icon});

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
