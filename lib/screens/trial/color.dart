import 'package:flutter/material.dart';

class TColors {
  TColors._();

  static const Color primary = Color.fromARGB(255, 115, 180, 237);
  static const Color secondary = Color(0xFFFF7434);
  static const Color accent = Colors.white;

  static const Color selected = Colors.green; // Example highlight color

  static const Gradient linearGradientlight = LinearGradient(
      begin: Alignment(0.0, 0.0),
      end: Alignment(0.707, -0.707),
      colors: [
        Color.fromARGB(255, 199, 222, 241),
        Color.fromARGB(255, 115, 180, 237),
        Colors.blue,
      ]);

  static const Gradient linearGradientdark = LinearGradient(
      begin: Alignment(0.0, 0.0),
      end: Alignment(0.707, -0.707),
      colors: [
        Color.fromARGB(255, 130, 104, 38), // Darker amber
        Color.fromARGB(255, 156, 124, 18), // Medium amber
        Color.fromARGB(255, 242, 183, 8),
      ]);

  static const Color textprimary = Color(0xff333333);
  static const Color textsecondary = Color(0xff6c757d);
  static const Color textaccent = Colors.white;

  static const Color light = Color(0xfff6f6f6);
  static const Color dark = Color(0xff272727);
  static const Color primaryBackground = Color(0xfff3f5ff);

  static const Color lightContainer = Color(0xfff6f6f6);
  static Color darkContainer = Colors.white.withOpacity(0.1);

  static const Color appBackground = Color(0xFFEFEFEF);
  static const Color orange = Color(0xFFFF7434);
  static const Color white = Colors.white;
  static const Color shadow = Color(0xFFE0E0E0);
  static const Color silverGray = Color(0xFFCCCCCC);
  static const Color black = Colors.black;
  static const Color textPrimary = Color(0xFF1C2D57);
  static const Color textSecondary = Color(0xFFD4D5FF);

  static const Color errorColor = Colors.red;
}
