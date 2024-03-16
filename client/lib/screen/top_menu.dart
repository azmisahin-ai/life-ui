import 'package:flutter/material.dart';

class TopMenu extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onMenuIconPressed;

  const TopMenu({
    super.key,
    required this.onMenuIconPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Client'),
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
