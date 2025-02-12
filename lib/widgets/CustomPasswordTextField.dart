import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/app_colors.dart';

class CustomPasswordTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final RxBool isPasswordVisible;
  final Function() togglePasswordVisibility;
  final bool showValidations;

  CustomPasswordTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.isPasswordVisible,
    required this.togglePasswordVisibility,
    this.showValidations = false, // Show validations only in signup & reset password
  }) : super(key: key);

  final RxString validationMessage = ''.obs;

  void validatePassword(String password) {
    if (password.isEmpty) {
      validationMessage.value = "Password cannot be empty";
    } else if (password.length < 8) {
      validationMessage.value = "Password must be at least 8 characters";
    } else if (!RegExp(r'[A-Z]').hasMatch(password)) {
      validationMessage.value = "Password must contain at least one uppercase letter";
    } else if (!RegExp(r'[0-9]').hasMatch(password)) {
      validationMessage.value = "Password must contain at least one digit";
    } else if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) {
      validationMessage.value = "Password must contain at least one special character";
    } else {
      validationMessage.value = ''; // No validation errors
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
          child: Obx(() => TextField(
                controller: controller,
                obscureText: !isPasswordVisible.value,
                onChanged: showValidations ? validatePassword : null,
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: const TextStyle(color: AppColors.textColors),
                  suffixIcon: IconButton(
                    icon: Icon(
                      isPasswordVisible.value ? Icons.visibility : Icons.visibility_off,
                      color: AppColors.textColors,
                    ),
                    onPressed: togglePasswordVisibility,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
