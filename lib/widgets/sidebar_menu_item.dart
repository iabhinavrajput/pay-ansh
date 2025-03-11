import 'package:flutter/material.dart';
import 'package:payansh/constants/app_colors.dart';

class SidebarMenuItem extends StatelessWidget {
  final Widget icon;
  final String title;
  final String subtitle;
  final Color? subtitleColor;
  final VoidCallback? onTap;

  const SidebarMenuItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.subtitleColor,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 44, 
        height: 44, 
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          gradient: AppColors.iconGradient,
        ),
        child: Center(
          child: SizedBox(
            width: 20,
            height: 20,
            child: icon,
          ),
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.drawerTextColor), // Reduced font size
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(fontSize: 12, color: subtitleColor ?? AppColors.textColors), // Reduced font size
      ),
      onTap: onTap,
    );
  }
}
