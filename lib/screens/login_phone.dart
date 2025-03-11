import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payansh/constants/app_colors.dart';
import 'package:payansh/screens/otp_verification.dart';
import 'package:payansh/widgets/CustomEmailTextField.dart';
import 'package:payansh/widgets/custom_text_field.dart';
import 'package:payansh/widgets/gradient_button.dart';
import 'package:payansh/widgets/mobile_field.dart';
import '../controllers/forgot_password.dart';

class LoginPhoneNum extends StatelessWidget {
  final TextEditingController phoneController = TextEditingController();

  final RxBool isPhoneValid = false.obs;

  LoginPhoneNum({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 80),
            const Text("LOGIN WITH OTP",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.1)),

            const SizedBox(height: 10),
            const Text(
                "We'll sent the OTP as a SMS to your registered mobile number",
                textAlign: TextAlign.center,
                style:
                    TextStyle(fontSize: 15, color: AppColors.greytextColors)),
            const SizedBox(height: 20),

            // Email Input Field
            CustomTextField(
              controller: phoneController, hintText: 'Enter Your Mobile Number', icon: Icons.phone_outlined,
            
            ),
            const SizedBox(height: 30),

            // Send OTP Button
            // Obx(() =>
            // forgotPasswordController.isLoading.value
            //     ? const CircularProgressIndicator()
            //     : GradientButton(
            //         text: "Send OTP",
            //         onPressed: isEmailValid.value ? () { forgotPasswordController
            //             .sendResetOTP(emailController.text);} : () {},
            //               isEnabled:
            //                   isEmailValid.value ),
            //       ),

            GradientButton(
                text: "Continue",
                onPressed: () {
                  Get.to(() => OtpVerification(
                        userId: 1234,
                      ));
                })
          ],
        ),
      ),
    );
  }
}
