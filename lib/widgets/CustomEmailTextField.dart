import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/app_colors.dart';

class CustomEmailTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon;

  CustomEmailTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.icon,
  });

  final RxString validationMessage = ''.obs;

  void validateEmail(String email) {
    if (email.isEmpty) {
      validationMessage.value = "Email cannot be empty";
    } else if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(email)) {
      validationMessage.value = "Enter a valid email address";
    } else {
      validationMessage.value = ''; // No errors
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.inputBackground,
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.emailAddress,
            onChanged: validateEmail, // Live validation
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(color: AppColors.textColors),
              suffixIcon:
                  Icon(icon, color: AppColors.textColors), // Custom icon
              border: InputBorder.none,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            ),
          ),
        ),
        Obx(() => validationMessage.value.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  validationMessage.value,
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              )
            : const SizedBox.shrink()),
      ],
    );
  }
}
