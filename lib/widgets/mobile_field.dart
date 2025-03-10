import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:payansh/constants/app_colors.dart';

class MobileNumberField extends StatelessWidget {
  final TextEditingController controller;

  const MobileNumberField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TextField(
          controller: controller,
          keyboardType: TextInputType.phone,
          maxLength: 10, // Restrict to 10 digits
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly, // Allow only numbers
            LengthLimitingTextInputFormatter(10), // Limit to 10 characters
          ],
          decoration: InputDecoration(
            counterText: "", // Hide the counter text below input field
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "+91",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade500, // Light gray prefix text
                ),
              ),
            ),
            prefixIconConstraints: const BoxConstraints(minWidth: 50),
            suffixIcon: ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [
                  AppColors.gradientStart,
                  AppColors.gradientEnd
                ], // Blue Gradient
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds),
              child: const Icon(Icons.phone_outlined,
                  color: Colors.white), // Keep it white for gradient effect
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  BorderSide(color: Colors.blue.shade300), // Light blue border
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.blue.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.blue, width: 2),
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          ),
        ),
        Positioned(
          left: 15,
          top: -5,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            color: Colors.white, // Matches background color
            child: ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [
                  AppColors.gradientStart,
                  AppColors.gradientEnd
                ], // Blue Gradient
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds),
              child: const Text(
                "Mobile Number*",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white, // Keep it white for shader to apply
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
