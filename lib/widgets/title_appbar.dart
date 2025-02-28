import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payansh/constants/app_colors.dart';

class TitleAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final String title;

  const TitleAppBar({
    super.key,
    required this.height,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(height),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.gradientStart, AppColors.gradientEnd],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.black26, blurRadius: 4, offset: Offset(0, 2)),
          ],
        ),
        child: AppBar(
          backgroundColor:
              Colors.transparent, // Make AppBar transparent to show gradient
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          leading: Navigator.canPop(context)
              ? IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Get.back(),
                )
              : null,
          elevation: 0, // Remove AppBar shadow, as we already have a boxShadow
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
