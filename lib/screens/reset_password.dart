import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/forgot_password.dart';
import '../widgets/gradient_button.dart';

class ResetPasswordScreen extends StatelessWidget {
  final ForgotPasswordController forgotPasswordController = Get.find();
  final TextEditingController otpController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Reset Password")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: otpController, decoration: InputDecoration(hintText: "Enter OTP")),
            SizedBox(height: 10),
            TextField(controller: newPasswordController, decoration: InputDecoration(hintText: "Enter New Password")),
            SizedBox(height: 10),
            TextField(controller: confirmPasswordController, decoration: InputDecoration(hintText: "Confirm Password")),
            SizedBox(height: 20),
            Obx(() => forgotPasswordController.isLoading.value
                ? CircularProgressIndicator()
                : GradientButton(
                    text: "Reset Password",
                    onPressed: () => forgotPasswordController.resetPassword(
                      otpController.text,
                      newPasswordController.text,
                      confirmPasswordController.text,
                    ),
                  )),
          ],
        ),
      ),
    );
  }
}
