import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payansh/controllers/otp_controller.dart';

class OtpVerification extends StatelessWidget {
  final int userId;
  OtpVerification({super.key, required this.userId});

  final OtpController otpController = Get.put(OtpController());

  @override
  Widget build(BuildContext context) {
    final TextEditingController otpControllerText = TextEditingController();

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
            TextField(
              controller: otpControllerText,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "OTP",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Obx(() => ElevatedButton(
                  onPressed: otpController.isLoading.value
                      ? null
                      : () {
                          otpController.verifyOtp(userId, otpControllerText.text);
                        },
                  child: otpController.isLoading.value
                      ? const CircularProgressIndicator()
                      : const Text("Verify OTP"),
                )),
          ],
        ),
      ),
    );
  }
}
