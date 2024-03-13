// features/evaluation/evaluation_view.dart

import 'package:flutter/material.dart';
import 'package:ui/features/evaluation/evaluation_card.dart';

class EvaluationView extends StatelessWidget {
  const EvaluationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Evaluation'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            EvaluationCard(title: 'Statistics', icon: Icons.show_chart),
          ],
        ),
      ),
    );
  }
}
