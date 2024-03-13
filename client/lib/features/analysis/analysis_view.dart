// features/analysis/analysis_view.dart

import 'package:flutter/material.dart';
import 'package:ui/features/analysis/analysis_card.dart';

class AnalysisView extends StatelessWidget {
  const AnalysisView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analysis'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AnalysisCard(title: 'Statistics', icon: Icons.show_chart),
          ],
        ),
      ),
    );
  }
}
