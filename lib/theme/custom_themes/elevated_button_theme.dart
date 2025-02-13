import 'package:flutter/material.dart';

class TElevatedButtonTheme {
  TElevatedButtonTheme._();

  static ButtonStyle lightElevatedButtonTheme = ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.black,
      backgroundColor: Colors.amber,
      disabledForegroundColor: Colors.black,
      disabledBackgroundColor: Colors.amber,
      side: const BorderSide(
        color: Color.fromARGB(255, 147, 118, 29),
      ),
      padding: const EdgeInsets.symmetric(vertical: 18),
      textStyle: const TextStyle(
          fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)));

  static ButtonStyle darkElevatedButtonTheme = ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.white,
      backgroundColor: const Color.fromARGB(255, 147, 118, 29),
      disabledForegroundColor: Colors.white,
      disabledBackgroundColor: const Color.fromARGB(255, 147, 118, 29),
      side: const BorderSide(color: Colors.amber),
      padding: const EdgeInsets.symmetric(vertical: 18),
      textStyle: const TextStyle(
          fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)));
}
