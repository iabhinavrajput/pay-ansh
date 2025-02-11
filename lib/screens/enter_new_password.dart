import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payansh/widgets/CustomPasswordTextField.dart';
import '../controllers/forgot_password.dart';
import '../widgets/gradient_button.dart';

class EnterNewPasswordScreen extends StatelessWidget {
  final ForgotPasswordController forgotPasswordController = Get.find();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final RxBool isPasswordVisible = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50),

            // Title
            const Text(
              "Enter New Password",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Lock Icon
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.blue.shade50,
              child:
                  const Icon(Icons.lock_outline, size: 40, color: Colors.blue),
            ),

            const SizedBox(height: 30),

            // New Password Field
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
              ),
              child: CustomPasswordTextField(
                controller: newPasswordController,
                hintText: "Enter your password",
                isPasswordVisible: isPasswordVisible,
                togglePasswordVisibility: () =>
                    isPasswordVisible.value = !isPasswordVisible.value,
                showValidations: true,
              ),
            ),

            const SizedBox(height: 15),

            // Confirm Password Field
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
              ),
              child: CustomPasswordTextField(
                controller: confirmPasswordController,
                hintText: "Re-enter your password",
                isPasswordVisible: isPasswordVisible,
                togglePasswordVisibility: () =>
                    isPasswordVisible.value = !isPasswordVisible.value,
                showValidations: true,
              ),
            ),

            const SizedBox(height: 30),

            // Continue Button
            Obx(() => forgotPasswordController.isLoading.value
                ? const CircularProgressIndicator()
                : GradientButton(
                    text: "Continue",
                    onPressed: () {
                      print(
                          "🔹 Stored Email: ${forgotPasswordController.email.value}");
                      print(
                          "🔢 Stored OTP: ${forgotPasswordController.otpCode.value}");
                      print("🔑 New Password: ${newPasswordController.text}");

                      if (newPasswordController.text ==
                          confirmPasswordController.text) {
                        forgotPasswordController.resetPassword(
                          forgotPasswordController
                              .email.value, // ✅ Ensure correct email is passed
                          forgotPasswordController.otpCode
                              .value, // ✅ Ensure OTP is stored correctly
                          newPasswordController.text,
                          confirmPasswordController.text,
                        );
                      } else {
                        Get.snackbar("Error", "Passwords do not match!",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.red,
                            colorText: Colors.white);
                      }
                    },
                  )),
          ],
        ),
      ),
    );
  }
}
