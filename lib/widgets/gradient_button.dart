import 'package:flutter/material.dart';
import 'package:payansh/constants/dimensions.dart';
import '../../constants/app_colors.dart';

class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed; // Allow nullable
  final bool isEnabled;

  const GradientButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isEnabled = true, // Default is true
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: Dimensions.dynamicHeight(context, 0.06),
      decoration: BoxDecoration(
        gradient: isEnabled
            ? const LinearGradient(
                colors: [AppColors.gradientStart, AppColors.gradientEnd],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              )
            :  LinearGradient(
                colors: [AppColors.gradientStart.withOpacity(0.5), AppColors.gradientEnd.withOpacity(0.5)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ), // No gradient when disabled
       
        borderRadius: BorderRadius.circular(10),
      ),
      
      child: ElevatedButton(
        onPressed: isEnabled ? onPressed : null, // Disable when not enabled
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: Text(text,
            style: const TextStyle(fontSize: 16, color: Colors.white)),
      ),
    );
  }
}
