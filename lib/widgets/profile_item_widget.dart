import 'package:flutter/material.dart';

class ProfileItemWidget extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? value;
  final Widget? valueWidget;
  final VoidCallback onEdit;

  const ProfileItemWidget({
    Key? key,
    required this.icon,
    required this.label,
    this.value,
    this.valueWidget,
    required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(label),
      subtitle: valueWidget ?? Text(value ?? ""),
      trailing: TextButton(
        onPressed: onEdit,
        child: const Text("Edit"),
      ),
    );
  }
}
