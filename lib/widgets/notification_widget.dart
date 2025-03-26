import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:payansh/constants/app_colors.dart';
import 'package:payansh/constants/dimensions.dart';
import 'package:payansh/theme/custom_themes/text_theme.dart';

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
              color: Color(0xA65A5A5B),
              width: Dimensions.dynamicWidth(context, 0.001)),
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
                  children: [
                    Text(text,style: TextStyle(fontSize: Dimensions.dynamicWidth(context, 0.035),),),
                    SizedBox(width: Dimensions.dynamicHeight(context, 0.01)),
                    Image.asset(
                      imagePath,
                      width: Dimensions.dynamicHeight(context, 0.015),
                    )
                  ],
                ),
                SizedBox(
                  width: Dimensions.dynamicWidth(
                      context, 0.7), // Limit width to avoid overflow
                  child: Text(
                    description,
                    style: TextStyle(
                      color: Color(0xB35A5A5B),
                      fontSize: Dimensions.dynamicWidth(context, 0.03),
                    ),
                    softWrap: true, // Allows wrapping
                    overflow:
                        TextOverflow.visible, // Ensures full text is shown
                  ),
                ),
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
