// features/evaluation/evaluation_card.dart

import 'package:flutter/material.dart';

class EvaluationCard extends StatelessWidget {
  final String title;
  final IconData icon;

  const EvaluationCard({super.key, required this.title, required this.icon});

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
