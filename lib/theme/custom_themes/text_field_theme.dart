import 'package:flutter/material.dart';

class TTextFormFieldTheme {
  TTextFormFieldTheme._();

  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: Colors.grey,
    suffixIconColor: Colors.grey,
    labelStyle: const TextStyle().copyWith(fontSize: 14, color: Colors.black),
    hintStyle: const TextStyle().copyWith(fontSize: 14, color: Colors.black54),
    errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal),
    floatingLabelStyle: const TextStyle().copyWith(
      color: Colors.black.withOpacity(0.8),
    ),
    filled: true,
    fillColor: Colors.transparent, // Transparent background
    border: const UnderlineInputBorder(
      borderSide: BorderSide(
        width: 1.5,
        color: Colors.grey,
      ),
    ),
    enabledBorder: const UnderlineInputBorder(
      borderSide: BorderSide(
        width: 1.5,
        color: Colors.grey, // Default border color
      ),
    ),
    focusedBorder: const UnderlineInputBorder(
      borderSide: BorderSide(
        width: 1.5,
        color: Colors.black, // Border color when focused
      ),
    ),
    errorBorder: const UnderlineInputBorder(
      borderSide: BorderSide(
        width: 1.5,
        color: Colors.red, // Border color on error
      ),
    ),
    focusedErrorBorder: const UnderlineInputBorder(
      borderSide: BorderSide(
        width: 2,
        color: Colors.orange, // Border color on focused error
      ),
    ),
  );

  static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 2,
    prefixIconColor: Colors.grey,
    suffixIconColor: Colors.grey,
    labelStyle: const TextStyle().copyWith(fontSize: 14, color: Colors.white),
    hintStyle: const TextStyle().copyWith(fontSize: 14, color: Colors.white54),
    errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal),
    floatingLabelStyle: const TextStyle().copyWith(
      color: Colors.white.withOpacity(0.8),
    ),
    filled: true,
    fillColor: Colors.transparent, // Transparent background
    border: const UnderlineInputBorder(
      borderSide: BorderSide(
        width: 1.5,
        color: Colors.grey,
      ),
    ),
    enabledBorder: const UnderlineInputBorder(
      borderSide: BorderSide(
        width: 1.5,
        color: Colors.grey, // Default border color
      ),
    ),
    focusedBorder: const UnderlineInputBorder(
      borderSide: BorderSide(
        width: 1.5,
        color: Colors.white, // Border color when focused
      ),
    ),
    errorBorder: const UnderlineInputBorder(
      borderSide: BorderSide(
        width: 1.5,
        color: Colors.red, // Border color on error
      ),
    ),
    focusedErrorBorder: const UnderlineInputBorder(
      borderSide: BorderSide(
        width: 2,
        color: Colors.orange, // Border color on focused error
      ),
    ),
  );
}
