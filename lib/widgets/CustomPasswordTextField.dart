import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/app_colors.dart';

class CustomPasswordTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final RxBool isPasswordVisible;
  final Function() togglePasswordVisibility;
  final bool showValidations;
  final Function(bool) onValidationChanged; // Callback for validation

  CustomPasswordTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.isPasswordVisible,
    required this.togglePasswordVisibility,
    this.showValidations =
        false, // Show validations only in signup & reset password
    required this.onValidationChanged,
  });

  final RxString validationMessage = ''.obs;

  void validatePassword(String password) {
    if (password.isEmpty) {
      validationMessage.value = "Password cannot be empty";
      onValidationChanged(false);
    } else if (password.length < 8) {
      validationMessage.value = "Password must be at least 8 characters";
      onValidationChanged(false);
    } else if (!RegExp(r'[A-Z]').hasMatch(password)) {
      validationMessage.value =
          "Password must contain at least one uppercase letter";
      onValidationChanged(false);
    } else if (!RegExp(r'[0-9]').hasMatch(password)) {
      validationMessage.value = "Password must contain at least one digit";
      onValidationChanged(false);
    } else if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) {
      validationMessage.value =
          "Password must contain at least one special character";
      onValidationChanged(false);
    } else {
      validationMessage.value = ''; // No validation errors
      onValidationChanged(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.iconBackground,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Obx(() => TextField(
                controller: controller,
                obscureText: !isPasswordVisible.value,
                onChanged: (value) {
                  validatePassword(
                      value); // ✅ Always validate, even if `showValidations` is false
                },
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: const TextStyle(color: AppColors.textColors),
                  suffixIcon: IconButton(
                    icon: Icon(
                      isPasswordVisible.value
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: AppColors.textColors,
                    ),
                    onPressed: togglePasswordVisibility,
                  ),
                  border: InputBorder.none,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                ),
              )),
        ),
        if (showValidations)
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
