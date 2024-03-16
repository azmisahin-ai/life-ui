// screen/left_menu.dart
import 'package:flutter/material.dart';
import 'package:ui/screen/menu.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RightMenu extends StatelessWidget {
  final Function(Widget) onMenuItemSelected;

  const RightMenu({super.key, required this.onMenuItemSelected});

  @override
  Widget build(BuildContext context) {
    return Menu(
      onMenuItemSelected: onMenuItemSelected,
      projectName: AppLocalizations.of(context)!.app_name,
    );
  }
}
