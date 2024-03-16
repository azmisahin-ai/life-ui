// screen/left_menu.dart
import 'package:flutter/material.dart';
import 'package:ui/screen/menu.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class LeftMenu extends StatelessWidget {
  final Function(Widget) onMenuItemSelected;

  const LeftMenu({super.key, required this.onMenuItemSelected});

  @override
  Widget build(BuildContext context) {
    return Menu(
      onMenuItemSelected: onMenuItemSelected,
      appName: AppLocalizations.of(context)!.app_name,
    );
  }
}
