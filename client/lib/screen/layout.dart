// screen/layout.dart
import 'package:flutter/material.dart';
import 'package:ui/l10n/app_localizations.dart';

class Layout extends StatelessWidget {
  const Layout({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppLocalizations.of(context).translate('Welcome'),
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ],
      ),
    );
  }
}
