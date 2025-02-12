import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/forgot_password.dart';
import '../widgets/gradient_button.dart';

class EnterNewPasswordScreen extends StatelessWidget {
  final ForgotPasswordController forgotPasswordController = Get.find();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

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
            const Text("Enter New Password", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.blue.shade50,
              child: const Icon(Icons.lock_outline, size: 40, color: Colors.blue),
            ),

            const SizedBox(height: 30),

            // New Password Field
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: newPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: "Enter your password",
                  suffixIcon: Icon(Icons.lock, color: Colors.blue),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                ),
              ),
            ),

            const SizedBox(height: 15),

            // Confirm Password Field
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: confirmPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: "Re-enter your password",
                  suffixIcon: Icon(Icons.lock, color: Colors.blue),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Continue Button
            Obx(() => forgotPasswordController.isLoading.value
                ? const CircularProgressIndicator()
                : GradientButton(
                    text: "Continue",
                    onPressed: () {
                      if (newPasswordController.text == confirmPasswordController.text) {
                        forgotPasswordController.resetPassword(
                          newPasswordController.text,
                          confirmPasswordController.text,
                        );
                      } else {
                        Get.snackbar("Error", "Passwords do not match!",
                            snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
                      }
                    },
                  )),
          ],
        ),
      ),
    );
  }
}
