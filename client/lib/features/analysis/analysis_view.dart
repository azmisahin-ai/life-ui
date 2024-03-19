// features/analysis/analysis_view.dart

import 'package:flutter/material.dart';
import 'package:ui/features/analysis/analysis_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AnalysisView extends StatelessWidget {
  const AnalysisView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.analysis_title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AnalysisCard(
                title: AppLocalizations.of(context)!.analysis_card_title,
                icon: Icons.show_chart),
          ],
        ),
      ),
    );
  }
}
