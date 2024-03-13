// lib/screen/menu.dart
import 'package:flutter/material.dart';
import 'package:ui/features/analysis/analysis_view.dart';
import 'package:ui/features/dashboard/dashboard_view.dart';
import 'package:ui/features/data_processing/data_processing_view.dart';
import 'package:ui/features/evaluation/evaluation_view.dart';
import 'package:ui/features/learning_model/learning_model_view.dart';
import 'package:ui/features/settings/settings_view.dart';
import 'package:ui/features/simulation/simulation_view.dart';
import 'package:ui/l10n/app_localizations.dart';

class Menu extends StatelessWidget {
  final Function(Widget) onMenuItemSelected;
  final String projectName;

  const Menu({
    super.key,
    required this.onMenuItemSelected,
    required this.projectName,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              projectName,
            ),
          ),
          _buildMenuItem(
              context,
              Icons.dashboard,
              AppLocalizations.of(context).dashboardTitle,
              const DashboardView()),
          _buildMenuItem(
              context,
              Icons.data_usage,
              AppLocalizations.of(context).dataProcessingTitle,
              const DataProcessingView()),
          _buildMenuItem(context, Icons.analytics,
              AppLocalizations.of(context).analysisTitle, const AnalysisView()),
          _buildMenuItem(
              context,
              Icons.lightbulb,
              AppLocalizations.of(context).learningModelTitle,
              const LearningModelView()),
          _buildMenuItem(
              context,
              Icons.sentiment_neutral,
              AppLocalizations.of(context).simulationTitle,
              const SimulationView()),
          _buildMenuItem(
              context,
              Icons.rate_review,
              AppLocalizations.of(context).evaluationTitle,
              const EvaluationView()),
          _buildMenuItem(context, Icons.settings,
              AppLocalizations.of(context).settingsTitle, const SettingsView()),
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
          Text(AppLocalizations.of(context).translate(titleKey)),
        ],
      ),
      onTap: () {
        onMenuItemSelected(view);
      },
    );
  }
}
