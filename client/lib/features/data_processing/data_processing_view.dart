// features/data_processing/data_processing_view.dart

import 'package:flutter/material.dart';
import 'package:ui/features/data_processing/data_processing_card.dart';

class DataProcessingView extends StatelessWidget {
  const DataProcessingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Processing'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DataProcessingCard(title: 'Statistics', icon: Icons.show_chart),
          ],
        ),
      ),
    );
  }
}
