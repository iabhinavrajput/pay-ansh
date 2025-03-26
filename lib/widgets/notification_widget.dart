import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:payansh/constants/app_colors.dart';
import 'package:payansh/constants/dimensions.dart';

class NotificationWidget extends StatelessWidget {
  final String text, description;
  final String imagePath; // ✅ Changed from IconData to String for image path
  const NotificationWidget({
    super.key,
    required this.text,
    required this.description,
    required this.imagePath, // ✅ Accept an image path instead of an icon
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Dimensions.dynamicWidth(context, 1),
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: EdgeInsets.all(Dimensions.dynamicWidth(context, 0.03)),
        child: Row(
          children: [
            bell(),
            SizedBox(
              width: Dimensions.dynamicWidth(context, 0.03),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [Text(text), Container
                  (height: 500,
                  width: 500,
                    child: SvgPicture.asset(imagePath))],
                ),
                Text(
                  description,
                  textWidthBasis: TextWidthBasis
                      .longestLine, // Calculates width based on longest line
                  // Limits text to 2 lines
                  // Allows automatic line breaking
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class bell extends StatelessWidget {
  const bell({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: Dimensions.dynamicWidth(context, 0.07),
        height: Dimensions.dynamicWidth(context, 0.07),
        decoration: BoxDecoration(
            color: AppColors.primaryBackground,
            borderRadius: BorderRadius.circular(50)),
        child: Transform.rotate(
            angle: -3 / 4, // Rotate by 45 degrees (in radians)
            child: ShaderMask(
              shaderCallback: (Rect bounds) {
                return LinearGradient(
                  colors: [
                    AppColors.gradientStart,
                    AppColors.gradientEnd
                  ], // Define gradient colors
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds);
              },
              child: Icon(
                Icons.notifications,
                size: Dimensions.dynamicWidth(context, 0.05),
                color:
                    Colors.white, // Use white so the gradient applies properly
              ),
            )));
  }
}
