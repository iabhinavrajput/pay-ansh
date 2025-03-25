import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payansh/controllers/auth_controller.dart';
import 'package:payansh/constants/app_colors.dart';
import 'package:payansh/constants/dimensions.dart';
import 'package:payansh/widgets/gradient_text.dart';
import 'package:payansh/widgets/gradient_button.dart';

class DeleteUserProfileOtp extends StatefulWidget {
  @override
  _DeleteUserProfileOtpState createState() => _DeleteUserProfileOtpState();
}

class _DeleteUserProfileOtpState extends State<DeleteUserProfileOtp> {
  final TextEditingController _otpController = TextEditingController();

  void _submitOtp() async {
    String otp = _otpController.text.trim();
    final AuthController authController = Get.find<AuthController>(); 

    if (otp.isNotEmpty) {
      await authController.verifyDeleteAccountOtp(otp);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter the OTP')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Dimensions.dynamicWidth(context, 0.14)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            const Text(
              "Forget Password",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              "We’ll send the OTP your registered\ne-mail Id",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 30),
            Image.asset(
              'assets/icon/Forget-icon-animation1.png',
              width: Dimensions.dynamicWidth(context, 0.3),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _otpController,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              maxLength: 4,
              decoration: const InputDecoration(
                counterText: "",
                border: OutlineInputBorder(),
                hintText: 'Enter OTP',
              ),
            ),
            const SizedBox(height: 40),
            GradientButton(
              text: "Verify OTP",
              onPressed: _submitOtp,
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {}, // You can add resend OTP functionality here
              child: GradientText(
                'Resend OTP ?',
                style: const TextStyle(fontSize: 17),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
