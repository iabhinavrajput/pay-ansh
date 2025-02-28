import 'package:flutter/material.dart';
import 'package:payansh/constants/app_colors.dart';
import 'package:payansh/constants/dimensions.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  const CustomAppBar({
    super.key,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: Dimensions.dynamicHeight(context, 0.7),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.gradientStart, AppColors.gradientEnd], // Left to Right Gradient
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2))
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
