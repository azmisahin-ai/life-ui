// features/data_processing/data_processing_card.dart

import 'package:flutter/material.dart';

class DataProcessingCard extends StatelessWidget {
  final String title;
  final IconData icon;

  const DataProcessingCard({super.key, required this.title, required this.icon});

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
