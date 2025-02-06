import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/forgot_password.dart';
import '../widgets/gradient_button.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final ForgotPasswordController forgotPasswordController = Get.put(ForgotPasswordController());
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Forgot Password")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: "Enter Your Email",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Obx(() => forgotPasswordController.isLoading.value
                ? CircularProgressIndicator()
                : GradientButton(
                    text: "Send OTP",
                    onPressed: () => forgotPasswordController.sendResetOTP(emailController.text),
                  )),
          ],
        ),
      ),
    );
  }
}
