import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payansh/constants/app_colors.dart';
import 'package:payansh/constants/dimensions.dart';
import 'package:payansh/widgets/CustomEmailTextField.dart';
import 'package:payansh/widgets/custom_text_field.dart';
import 'package:payansh/widgets/gradient_button.dart';
import '../controllers/forgot_password.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final ForgotPasswordController forgotPasswordController =
      Get.put(ForgotPasswordController());
  final TextEditingController emailController = TextEditingController();

  final RxBool isEmailValid = false.obs;

  ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 80),
            const Text("RESET PASSWORD",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Image.asset("assets/images/logo.png", height: 30),
            const SizedBox(height: 30),
             Text("Enter your email to receive an OTP",
             textAlign: TextAlign.center,
                style:
                    TextStyle(fontSize: Dimensions.dynamicWidth(context, 0.045), color: AppColors.greytextColors)),
            const SizedBox(height: 20),

            // Email Input Field
            CustomEmailTextField(
              controller: emailController,
              hintText: "Enter your email",
              icon: Icons.message,
              onValidationChanged: (isValid) {
                isEmailValid.value = isValid;
                print("Email Valid: $isValid");
              },
            ),
            const SizedBox(height: 30),

            // Send OTP Button
            Obx(() => forgotPasswordController.isLoading.value
                ? const CircularProgressIndicator()
                : GradientButton(
                    text: "Send OTP",
                    onPressed: isEmailValid.value ? () { forgotPasswordController
                        .sendResetOTP(emailController.text);} : () {},
                          isEnabled:
                              isEmailValid.value ),
                  ),
          ],
        ),
      ),
    );
  }
}
