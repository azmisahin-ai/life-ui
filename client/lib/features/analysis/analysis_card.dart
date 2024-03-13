// features/analysis/analysis_card.dart

import 'package:flutter/material.dart';

class AnalysisCard extends StatelessWidget {
  final String title;
  final IconData icon;

  const AnalysisCard({super.key, required this.title, required this.icon});

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
