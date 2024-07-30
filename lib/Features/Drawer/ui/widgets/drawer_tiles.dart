
import 'package:flutter/material.dart';

class DrawerTiles extends StatelessWidget {
  final String text;
  final bool isLogout;
  final IconData icon;
  final VoidCallback onTap;
  const DrawerTiles({
    super.key,
    required this.text,
    this.isLogout = false,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(
        text,
        style: const TextStyle(fontSize: 17),
      ),
      leading: Icon(
        icon,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
