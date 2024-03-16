// lib/screen/menu.dart
import 'package:flutter/material.dart';
import 'package:ui/features/dashboard/dashboard_view.dart';
import 'package:ui/features/analysis/analysis_view.dart';
import 'package:ui/features/data_processing/data_processing_view.dart';
import 'package:ui/features/evaluation/evaluation_view.dart';
import 'package:ui/features/learning_model/learning_model_view.dart';
import 'package:ui/features/simulation/simulation_view.dart';
import 'package:ui/features/settings/settings_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Menu extends StatelessWidget {
  final Function(Widget) onMenuItemSelected;
  final String appName;

  const Menu({
    super.key,
    required this.onMenuItemSelected,
    required this.appName,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              appName,
            ),
          ),
          _buildMenuItem(
              context,
              Icons.dashboard,
              AppLocalizations.of(context)!.dashboard_title,
              const DashboardView()),
          _buildMenuItem(
              context,
              Icons.data_usage,
              AppLocalizations.of(context)!.data_procession_title,
              const DataProcessingView()),
          _buildMenuItem(
              context,
              Icons.analytics,
              AppLocalizations.of(context)!.analysis_title,
              const AnalysisView()),
          _buildMenuItem(
              context,
              Icons.lightbulb,
              AppLocalizations.of(context)!.learning_model_title,
              const LearningModelView()),
          _buildMenuItem(
              context,
              Icons.sentiment_neutral,
              AppLocalizations.of(context)!.simulation_title,
              const SimulationView()),
          _buildMenuItem(
              context,
              Icons.rate_review,
              AppLocalizations.of(context)!.evaluation_title,
              const EvaluationView()),
          _buildMenuItem(
              context,
              Icons.settings,
              AppLocalizations.of(context)!.settings_title,
              const SettingsView()),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
      BuildContext context, IconData icon, String titleKey, Widget view) {
    return ListTile(
      title: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 10),
          Text(titleKey),
        ],
      ),
      onTap: () {
        onMenuItemSelected(view);
      },
    );
  }
}
