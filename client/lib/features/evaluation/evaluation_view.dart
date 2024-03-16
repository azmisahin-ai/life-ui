// features/evaluation/evaluation_view.dart

import 'package:flutter/material.dart';
import 'package:ui/features/evaluation/evaluation_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EvaluationView extends StatelessWidget {
  const EvaluationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.evaluation_title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            EvaluationCard(
                title: AppLocalizations.of(context)!.evaluation_card_title,
                icon: Icons.show_chart),
          ],
        ),
      ),
    );
  }
}
