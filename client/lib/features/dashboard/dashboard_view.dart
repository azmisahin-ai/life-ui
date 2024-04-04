// features/dashboard/dashboard_view.dart

import 'package:flutter/material.dart';
import 'package:ui/features/dashboard/dashboard_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.dashboard_title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DashboardCard(
                title: AppLocalizations.of(context)!.dashboard_card_title,
                icon: Icons.show_chart),
          ],
        ),
      ),
    );
  }
}
