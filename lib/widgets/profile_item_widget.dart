import 'package:flutter/material.dart';
import 'package:payansh/constants/app_colors.dart';
import 'package:payansh/constants/dimensions.dart';
import 'package:payansh/theme/custom_themes/text_theme.dart';

class ProfileItemWidget extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? value;
  final Widget? valueWidget;
  final int? verified; // 0 = Unverified, 1 = Verified
  final VoidCallback onEdit;

  const ProfileItemWidget({
    Key? key,
    required this.icon,
    required this.label,
    this.value,
    this.valueWidget,
    this.verified,
    required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 44,
        height: 44,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          gradient: AppColors.iconGradient,
        ),
        child: ShaderMask(
          shaderCallback: (Rect bounds) {
            return LinearGradient(
              colors: [AppColors.gradientStart, AppColors.gradientEnd],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(bounds);
          },
          blendMode: BlendMode.srcIn,
          child: Icon(
            icon,
            color: Colors.white,
            size: Dimensions.dynamicWidth(context, 0.05),
          ),
        ),
      ),
      title: Text(
        label,
        style: TTextTheme.vsmallText,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          valueWidget ??
              Text(
                value ?? "",
                style: TTextTheme.blueText,
              ),
          if (verified != null)
            verified == 1
                ? Row(
                    children: [
                      Text(
                        "Verified",
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(Icons.check_circle, color: Colors.green, size: 16),
                    ],
                  )
                : Container(
                  width: Dimensions.dynamicWidth(context, 0.25),
                    padding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: [
                        Text(
                          "Unverified",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(Icons.warning, color: Colors.red, size: Dimensions.dynamicWidth(context, 0.03)),
                      ],
                    ),
                  ),
        ],
      ),
      trailing: TextButton(
        onPressed: onEdit,
        child: Text(
          "Edit",
          style: TextStyle(
            color: const Color(0xff1E5262),
            fontSize: Dimensions.dynamicWidth(context, 0.04),
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
