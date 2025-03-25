import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payansh/controllers/auth_controller.dart';
import '../services/api_service.dart';

class OtpVerificationScreen extends StatefulWidget {
  @override
  _OtpVerificationScreenState createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final TextEditingController _otpController = TextEditingController();
  
  void _submitOtp() async {
  String otp = _otpController.text.trim();
  final AuthController authController = Get.find<AuthController>(); // GetX Controller Instance

  if (otp.isNotEmpty) {
    await authController.verifyDeleteAccountOtp(otp);
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Please enter the OTP')),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Verify OTP')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Enter the OTP sent to your email', textAlign: TextAlign.center),
            SizedBox(height: 20),
            TextField(
              controller: _otpController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter OTP',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitOtp,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
