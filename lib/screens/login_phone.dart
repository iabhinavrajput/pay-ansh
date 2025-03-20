import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payansh/constants/app_colors.dart';
import 'package:payansh/screens/otp_verification.dart';
import 'package:payansh/widgets/custom_text_field.dart';
import 'package:payansh/widgets/gradient_button.dart';

class LoginPhoneNum extends StatelessWidget {
  final TextEditingController phoneController = TextEditingController();
  final RxBool isPhoneValid = false.obs; // Reactive state for validation

  LoginPhoneNum({super.key}) {
    phoneController.addListener(() {
      String text = phoneController.text;

      // Remove non-numeric characters
      text = text.replaceAll(RegExp(r'[^0-9]'), '');

      // Trim to 10 characters max
      if (text.length > 10) {
        text = text.substring(0, 10);
      }

      // Update text and cursor position
      if (phoneController.text != text) {
        phoneController.text = text;
        phoneController.selection = TextSelection.fromPosition(
          TextPosition(offset: text.length),
        );
      }

      // Validate only if exactly 10 digits
      isPhoneValid.value = text.length == 10;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 80),
            const Text(
              "LOGIN WITH OTP",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.1),
            ),
            const SizedBox(height: 10),
            const Text(
              "We'll send the OTP as an SMS to your registered mobile number",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, color: AppColors.greytextColors),
            ),
            const SizedBox(height: 20),

            // Phone Input Field
            CustomTextField(
              controller: phoneController,
              hintText: 'Enter Your Mobile Number',
              icon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
            ),

            const SizedBox(height: 30),

            // Continue Button with validation
            Obx(() => GradientButton(
                  text: "Continue",
                  onPressed: isPhoneValid.value
                      ? () {
                          Get.to(() => OtpVerification(userId: 1234));
                        }
                      : null, // Disable button if invalid
                  isEnabled: isPhoneValid.value, // Show disabled state
                )),
          ],
        ),
      ),
    );
  }
}
