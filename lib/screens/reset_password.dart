import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/forgot_password.dart';
import '../widgets/gradient_button.dart';

class ResetPasswordScreen extends StatelessWidget {
  final ForgotPasswordController forgotPasswordController = Get.find();
  final List<TextEditingController> otpControllers =
      List.generate(4, (index) => TextEditingController());
  final List<FocusNode> otpFocusNodes = List.generate(4, (index) => FocusNode());

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
            Obx(() => Text(
                  forgotPasswordController.isSignupOtp.value
                      ? "Verify Your Email"
                      : "Forget Password",
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                )),
            const SizedBox(height: 10),

            // Subtitle
            Obx(() => Text(
                  forgotPasswordController.isSignupOtp.value
                      ? "Enter the OTP sent to your email to verify your account"
                      : "We’ll send the OTP as an E-Mail to your e-mail Id",
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                )),
            const SizedBox(height: 30),

            // Lock Icon
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.blue.shade50,
              child: const Icon(Icons.lock_outline, size: 40, color: Colors.blue),
            ),

            const SizedBox(height: 30),

            // OTP Input Fields
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(4, (index) {
                return Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: otpControllers[index],
                    focusNode: otpFocusNodes[index],
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    decoration: const InputDecoration(
                      counterText: "",
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      if (value.isNotEmpty && index < 3) {
                        FocusScope.of(context).nextFocus();
                      } else if (value.isEmpty && index > 0) {
                        FocusScope.of(context).previousFocus();
                      }
                    },
                  ),
                );
              }),
            ),

            const SizedBox(height: 20),

            // Resend OTP Timer
            Obx(() => Text(
                  "OTP expires in: ${forgotPasswordController.otpTimer.value}s",
                  style: const TextStyle(color: Colors.red),
                )),

            const SizedBox(height: 20),

            // Verify Button
            Obx(() => forgotPasswordController.isLoading.value
                ? const CircularProgressIndicator()
                : GradientButton(
                    text: "Verify",
                    onPressed: () {
                      String otp = otpControllers.map((controller) => controller.text).join();
                      forgotPasswordController.verifyOTP(otp);
                    },
                  )),
          ],
        ),
      ),
    );
  }
}
