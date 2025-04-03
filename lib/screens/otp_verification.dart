import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payansh/constants/dimensions.dart';
import 'package:payansh/controllers/otp_controller.dart';
import 'package:payansh/screens/common_otp.dart';

class OtpVerification extends StatelessWidget {
  final int userId;
  OtpVerification({super.key, required this.userId});

  final OtpController otpController = Get.put(OtpController());

  @override
  Widget build(BuildContext context) {
    return CommonOtpScreen(
      title: "OTP Verification",
      subtitle: "We'll send the OTP to your registered E-mail",
      imagePath: 'assets/gif/auth/otp.gif',
      onOtpSubmit: (otp) => otpController.verifyOtp(userId, otp), onResendOtp: () {  },
      // onResendOtp: () => otpController.resendOtp(userId),
    );
  }
}
