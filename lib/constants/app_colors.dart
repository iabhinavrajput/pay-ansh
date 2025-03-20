import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryBackground = Color(0xFFDAECFF);
  static const Color gradientStart = Color(0xFF4686C5);
  static const Color gradientEnd = Color(0xFF41C6EE);
  static const Color inputBackground = Color(0x69DFE7EE);
  static const Color textColors = Color(0xFFB8B8BC);
  static const Color greytextColors = Color(0xFF5A5A5B);
  static const Color iconBackground = Color(0x33CFE3F7);
  static const Color verifiedColor = Colors.green;
  static const Color unverifiedColor = Colors.red;
  static const Color drawerTextColor = Color(0xFF346CA4);
  static const Color pendingColor = Color(0xFFF09E58);
  static const Color helpColor = Color(0x334686c5);
  static const Color kycContainerColor = Color(0xffFCECDE);
  static const Color kycTextColor = Color(0xFF5A5A5B);
  static const Color kycBorderDot = Color(0xAD4686C5);
  static const Color kycBorderDotShadow = Color(0x1F4686C5);

  static const LinearGradient appBarGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF4686C5), // #4686C5
      Color(0xFF41C6EE), // #41C6EE
    ],
  );

  static const LinearGradient userLetterBg = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF4686C5), // #4686C5
      Color(0xFF41C6EE), // #41C6EE
    ],
    stops: [0.1876, 0.9483],
    transform:
        GradientRotation(133 * (3.1415927 / 180)), // Convert degrees to radians
  );

  // Gradient for SidebarMenuItem icon background
  static const LinearGradient iconGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color.fromRGBO(207, 227, 247, 0.14), // rgba(207, 227, 247, 0.14)
      Color.fromRGBO(65, 198, 238, 0.14), // rgba(65, 198, 238, 0.14)
    ],
    stops: [0.08, 0.92], // Matching the given CSS stops
  );
  static const LinearGradient drawerColourUser = LinearGradient(
    colors: [
      Color.fromRGBO(70, 134, 197, 0.12),
      Color.fromRGBO(65, 194, 236, 0.20),
    ],
  );
}
