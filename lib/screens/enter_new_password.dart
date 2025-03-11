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

  final RxBool isNewPasswordVisible = false.obs;
  final RxBool isConfirmPasswordVisible = false.obs;
  final RxBool isNewPasswordValid = false.obs;
  final RxBool isConfirmPasswordValid = false.obs;
  final RxString newPasswordError = ''.obs;
  final RxString confirmPasswordError = ''.obs;

  EnterNewPasswordScreen({super.key});

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
            const Text("Enter New Password",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
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
                isPasswordVisible: isNewPasswordVisible,
                togglePasswordVisibility: () {
                  isNewPasswordVisible.value = !isNewPasswordVisible.value;
                },
                showValidations: false,
                onValidationChanged: (isValid) {
                  isNewPasswordValid.value = isValid;
                  newPasswordError.value =
                      isValid ? '' : 'Password is not valid';
                },
              ),
            ),
            Obx(() => newPasswordError.value.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.only(top: 5, left: 5),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        newPasswordError.value,
                        style: const TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    ),
                  )
                : const SizedBox()),

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
                isPasswordVisible: isConfirmPasswordVisible,
                togglePasswordVisibility: () {
                  isConfirmPasswordVisible.value =
                      !isConfirmPasswordVisible.value;
                },
                showValidations: false,
                onValidationChanged: (isValid) {
                  isConfirmPasswordValid.value = isValid;
                  confirmPasswordError.value =
                      isValid ? '' : 'Password does not match';
                },
              ),
            ),
            Obx(() => confirmPasswordError.value.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.only(top: 5, left: 5),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        confirmPasswordError.value,
                        style: const TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    ),
                  )
                : const SizedBox()),

            const SizedBox(height: 30),

            // Continue Button
            Obx(() => forgotPasswordController.isLoading.value
                ? const CircularProgressIndicator()
                : GradientButton(
                    text: "Continue",
                    onPressed: () {
                      if (newPasswordController.text ==
                          confirmPasswordController.text) {
                        forgotPasswordController.resetPassword(
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
