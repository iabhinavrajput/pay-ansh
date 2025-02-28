import 'package:flutter/material.dart';

class SidebarMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color? subtitleColor;

  const SidebarMenuItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.subtitleColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle, style: TextStyle(color: subtitleColor ?? Colors.black)),
      onTap: () {
        // Define your navigation or functionality here.
      },
    );
  }
}
