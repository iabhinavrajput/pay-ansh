import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payansh/controllers/auth_controller.dart';
import 'package:payansh/screens/common_otp.dart';

class DeleteUserProfileOtp extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return CommonOtpScreen(
      title: "Account Deletion",
      subtitle: "We’ll send the OTP to your registered\ne-mail ID",
      imagePath: 'assets/icon/forget.png',
      onOtpSubmit: (otp) => authController.verifyDeleteAccountOtp(otp),
      onResendOtp: () async {
        await AuthController.deleteAccountInitiate(context);
      },
    );
  }
}
