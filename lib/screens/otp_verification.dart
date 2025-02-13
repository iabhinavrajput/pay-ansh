import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payansh/controllers/otp_controller.dart';
import 'package:payansh/widgets/otp_input.dart';
import 'package:lottie/lottie.dart';

class OtpVerification extends StatelessWidget {
  final int userId;
  OtpVerification({super.key, required this.userId});

  final OtpController otpController = Get.put(OtpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("OTP Verification")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Enter the OTP sent to your email",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.blue.shade50,
              child: Lottie.asset(
                'assets/json/message_gif.json', // Update the path to your Lottie file
                width: 60, // Adjust size as needed
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),

            // ✅ Use the OTPInput widget
            OtpInput(
              onOtpEntered: (otp) => otpController.verifyOtp(userId, otp),
              otpTimer: otpController.otpTimer, // Now it's an RxInt
              isLoading: otpController.isLoading,
              onVerify: () {},
            ),
          ],
        ),
      ),
    );
  }
}
