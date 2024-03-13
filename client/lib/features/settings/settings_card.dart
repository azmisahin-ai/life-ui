// features/settings/settings_card.dart
import 'package:flutter/material.dart';

class SettingsCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final void Function()? onTap; // Değişiklik burada

  const SettingsCard({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
  }) : super(key: key); // Değişiklik burada

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }
}
