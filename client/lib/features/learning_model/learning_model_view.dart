// features/learning_model/learning_model_view.dart

import 'package:flutter/material.dart';
import 'package:ui/features/learning_model/learning_model_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LearningModelView extends StatelessWidget {
  const LearningModelView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.learning_model_title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LearningModelCard(
                title: AppLocalizations.of(context)!.learning_model_card_title,
                icon: Icons.show_chart),
          ],
        ),
      ),
    );
  }
}
