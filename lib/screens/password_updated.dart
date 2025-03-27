import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payansh/constants/dimensions.dart';
import 'package:payansh/screens/login_screen.dart';
import 'package:payansh/widgets/gradient_button.dart';

class PasswordUpdated extends StatefulWidget {
  const PasswordUpdated({super.key});

  @override
  State<PasswordUpdated> createState() => _PasswordUpdatedState();
}

class _PasswordUpdatedState extends State<PasswordUpdated> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAll(() => LoginScreen()); // Redirect to login screen
        return false; // Prevent default back button behavior
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          margin: EdgeInsets.symmetric(
              horizontal: Dimensions.dynamicWidth(context, 0.1)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: Dimensions.dynamicHeight(context, 0.1)),
              const Text("Your Password has\nbeen updated",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
              SizedBox(height: Dimensions.dynamicWidth(context, 0.08)),
              Image.asset(
                'assets/icon/password_updated.png',
                width: Dimensions.dynamicWidth(context, 0.2),
              ),
              SizedBox(height: Dimensions.dynamicWidth(context, 0.15)),
              GradientButton(
                  text: 'Go back to Login!',
                  onPressed: () {
                    Get.offAll(() => LoginScreen());
                  })
            ],
          ),
        ),
      ),
    );
  }
}
