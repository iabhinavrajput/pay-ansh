import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payansh/constants/app_colors.dart';
import 'package:payansh/constants/dimensions.dart';

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
      child: Stack(
        children: [
          Container(
            height: height,
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
          ),
          Positioned(
            bottom: 15, // Adjust to position text near the bottom
            left: 16,
            right: 16,
            child: Row(
              children: [
                Navigator.canPop(context)
                ? IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Get.back(),
                  )
                : const SizedBox
                    .shrink(),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style:  TextStyle(
                    fontSize: Dimensions.dynamicWidth(context, 0.045),
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          // Positioned(
          //   bottom: 25,
          //   left: 0,
          //   child: Navigator.canPop(context)
          //       ? IconButton(
          //           icon: const Icon(Icons.arrow_back, color: Colors.white),
          //           onPressed: () => Get.back(),
          //         )
          //       : const SizedBox
          //           .shrink(), // Fix: Use SizedBox.shrink() instead of null
          // ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
