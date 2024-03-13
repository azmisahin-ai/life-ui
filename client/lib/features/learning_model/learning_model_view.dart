// features/learning_model/learning_model_view.dart

import 'package:flutter/material.dart';
import 'package:ui/features/learning_model/learning_model_card.dart';

class LearningModelView extends StatelessWidget {
  const LearningModelView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Learning Model'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LearningModelCard(title: 'Statistics', icon: Icons.show_chart),
          ],
        ),
      ),
    );
  }
}
