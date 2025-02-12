import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/forgot_password.dart';
import '../widgets/otp_input.dart';

class ResetPasswordScreen extends StatelessWidget {
  final ForgotPasswordController forgotPasswordController = Get.find();

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
            Obx(() => Text(
                  forgotPasswordController.isSignupOtp.value
                      ? "Verify Your Email"
                      : "Forget Password",
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                )),
            const SizedBox(height: 10),
            Obx(() => Text(
                  forgotPasswordController.isSignupOtp.value
                      ? "Enter the OTP sent to your email to verify your account"
                      : "We’ll send the OTP as an E-Mail to your e-mail Id",
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                )),
            const SizedBox(height: 30),

            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.blue.shade50,
              child: const Icon(Icons.lock_outline, size: 40, color: Colors.blue),
            ),
            const SizedBox(height: 30),

            // ✅ Use the reusable OTP input widget
            OtpInput(
              onOtpEntered: (otp) => forgotPasswordController.verifyOTP(otp),
              otpTimer: forgotPasswordController.otpTimer,
              isLoading: forgotPasswordController.isLoading,
              onVerify: () {},
            ),
          ],
        ),
      ),
    );
  }
}
