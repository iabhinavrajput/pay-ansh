import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payansh/constants/dimensions.dart';
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
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Dimensions.dynamicWidth(context, 0.1)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: Dimensions.dynamicHeight(context, 0.07),
            ),
            Text(
              "OTP Verification",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: Dimensions.dynamicHeight(context, 0.01),
            ),

            const Text(
              "We'll sent the OTP as a SMS to your registered mobile number",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey),
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
