import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payansh/constants/app_colors.dart';
import 'package:payansh/theme/custom_themes/text_theme.dart';
import 'package:payansh/widgets/CustomEmailTextField.dart';
import 'package:payansh/widgets/custom_text_field.dart';
import 'package:payansh/widgets/gradient_button.dart';
import '../controllers/forgot_password.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final ForgotPasswordController forgotPasswordController =
      Get.put(ForgotPasswordController());
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 80),
            Text(
              "RESET PASSWORD",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 10),
            Image.asset("assets/images/logo.png", height: 30),
            const SizedBox(height: 30),
            const Text(
              "Enter your email to receive an OTP",
              style: TextStyle(fontSize: 18, color: AppColors.greytextColors),
            ),
            const SizedBox(height: 20),
            CustomEmailTextField(
              controller: emailController,
              hintText: "Enter your email",
              icon: Icons.message,
            ),
            const SizedBox(height: 30),
            Obx(() => forgotPasswordController.isLoading.value
                ? const CircularProgressIndicator()
                : GradientButton(
                    text: "Send OTP",
                    onPressed: () => forgotPasswordController
                        .sendResetOTP(emailController.text),
                  )),
          ],
        ),
      ),
    );
  }
}
