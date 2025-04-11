import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:payansh/constants/app_colors.dart';
import 'package:payansh/constants/dimensions.dart';

class AppBarImage extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final String title;
  final String? imageAsset;

  const AppBarImage({
    super.key,
    required this.title,
    this.imageAsset, required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(height),
      child: Stack(
        children: [
          // Gradient background
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
                  color: Colors.black26,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
          ),
          // AppBar content
          Positioned(
            bottom: 15,
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Back button
                Navigator.canPop(context)
                    ? IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Get.back(),
                      )
                    : const SizedBox(
                        width: 48), // Placeholder to maintain spacing

                // Title
                Expanded(
                  child: Text(
                    title,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: Dimensions.dynamicWidth(context, 0.045),
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),

                // Image (if provided)
                imageAsset != null
                    ? Image.asset(
                        imageAsset!,
                        height: 28,
                        width: 28,
                        fit: BoxFit.contain,
                      )
                    : SvgPicture.asset("assets/logo/Bharat_Connect.svg",width: Dimensions.dynamicWidth(context, 0.13),), // Placeholder to balance layout
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
