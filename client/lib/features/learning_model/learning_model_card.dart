// features/learning_model/learning_model_card.dart

import 'package:flutter/material.dart';

class LearningModelCard extends StatelessWidget {
  final String title;
  final IconData icon;

  const LearningModelCard({super.key, required this.title, required this.icon});

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
