// features/data_processing/data_processing_view.dart

import 'package:flutter/material.dart';
import 'package:ui/features/data_processing/data_processing_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DataProcessingView extends StatelessWidget {
  const DataProcessingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.data_procession_title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DataProcessingCard(
                title: AppLocalizations.of(context)!.data_procession_card_title,
                icon: Icons.show_chart),
          ],
        ),
      ),
    );
  }
}
