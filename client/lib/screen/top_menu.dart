import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TopMenu extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onMenuIconPressed;

  const TopMenu({
    super.key,
    required this.onMenuIconPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(AppLocalizations.of(context)!.app_name),
      actions: [
        IconButton(
          icon: const Icon(Icons.menu),
          onPressed: onMenuIconPressed,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
