import 'package:flutter/material.dart';
import 'package:payansh/constants/app_colors.dart';

class TTextTheme {
  TTextTheme._();

  static TextTheme lightTextTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(
        fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.black, fontFamily: 'DMSans'),
    headlineMedium: const TextStyle().copyWith(
        fontSize: 24.0, fontWeight: FontWeight.w600, color: Colors.black, fontFamily: 'DMSans'),
    headlineSmall: const TextStyle().copyWith(
        fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.black, fontFamily: 'DMSans'),

    titleLarge: const TextStyle().copyWith(fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.black, fontFamily: 'DMSans'),
    titleMedium: const TextStyle().copyWith(fontSize: 16.0, fontWeight: FontWeight.w500, color: Colors.black, fontFamily: 'DMSans'),
    titleSmall: const TextStyle().copyWith(fontSize: 16.0, fontWeight: FontWeight.w400, color: Colors.black, fontFamily: 'DMSans'),

    bodyLarge: const TextStyle().copyWith(fontSize: 14.0, fontWeight: FontWeight.w500, color: Colors.black, fontFamily: 'DMSans'),
    bodyMedium: const TextStyle().copyWith(fontSize: 14.0, fontWeight: FontWeight.normal, color: Color(0xFF5A5A5B), fontFamily: 'DMSans'),
    bodySmall: const TextStyle().copyWith(fontSize: 14.0, fontWeight: FontWeight.w500, color: Colors.black.withOpacity(0.5), fontFamily: 'DMSans'),

    labelLarge: const TextStyle().copyWith(fontSize: 20.0, fontWeight: FontWeight.normal, color: Colors.black, fontFamily: 'DMSans'),
    labelMedium: const TextStyle().copyWith(fontSize: 20.0, fontWeight: FontWeight.normal, color: Colors.black.withOpacity(0.3), fontFamily: 'DMSans'),
        labelSmall: const TextStyle().copyWith(fontSize: 18.0, fontWeight: FontWeight.normal, color: Colors.black.withOpacity(0.3), fontFamily: 'DMSans'),

  );

  static const TextStyle heading = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.black,
    fontFamily: 'DMSans',
  );

  static const TextStyle subtitle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: Colors.black,
    fontFamily: 'DMSans',
  );

  static const TextStyle link = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.bold,
    color: AppColors.gradientStart,
    fontFamily: 'DMSans',
  );

  static const TextStyle buttonText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.gradientStart,
    fontFamily: 'DMSans',
  );



  static TextTheme darkTextTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(
        fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'DMSans'),
    headlineMedium: const TextStyle().copyWith(
        fontSize: 24.0, fontWeight: FontWeight.w600, color: Colors.white, fontFamily: 'DMSans'),
    headlineSmall: const TextStyle().copyWith(
        fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.white, fontFamily: 'DMSans'),

    titleLarge: const TextStyle().copyWith(fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.white, fontFamily: 'DMSans'),
    titleMedium: const TextStyle().copyWith(fontSize: 16.0, fontWeight: FontWeight.w500, color: Colors.white, fontFamily: 'DMSans'),
    titleSmall: const TextStyle().copyWith(fontSize: 16.0, fontWeight: FontWeight.w400, color: Colors.white, fontFamily: 'DMSans'),

    bodyLarge: const TextStyle().copyWith(fontSize: 24.0, fontWeight: FontWeight.w500, color: Colors.white, fontFamily: 'DMSans'),
    bodyMedium: const TextStyle().copyWith(fontSize: 18.0, fontWeight: FontWeight.normal, color: Colors.white, fontFamily: 'DMSans'),
    bodySmall: const TextStyle().copyWith(fontSize: 14.0, fontWeight: FontWeight.w500, color: Colors.white.withOpacity(0.5), fontFamily: 'DMSans'),

    labelLarge: const TextStyle().copyWith(fontSize: 20.0, fontWeight: FontWeight.normal, color: Colors.white, fontFamily: 'DMSans'),
    labelMedium: const TextStyle().copyWith(fontSize: 18.0, fontWeight: FontWeight.normal, color: Colors.white.withOpacity(0.5), fontFamily: 'DMSans'),
  );
}
