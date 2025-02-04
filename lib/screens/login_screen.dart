import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';
import '../constants/app_colors.dart';
import '../widgets/gradient_button.dart';

class LoginScreen extends StatelessWidget {
  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(47),
          child: Column(
            children: [
              Text("WELCOME TO", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              // SizedBox(height: 40),
              
              // Logo
              Image.asset('assets/images/logo.png', width: screenWidth * 0.5),
              
              SizedBox(height: 20),

              // Illustration
              Image.asset('assets/images/login.png', width: screenWidth * 0.8),

              SizedBox(height: 20),

              // Email Input
              TextField(
                decoration: InputDecoration(
                  hintText: "Enter Your Email or Phone",
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),

              SizedBox(height: 15),

              // Password Input
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Enter your password",
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),

              SizedBox(height: 10),

              // Remember Me & Forgot Password
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(value: false, onChanged: (value) {}),
                      Text("Remember me"),
                    ],
                  ),
                  Text("Forgot Password?", style: TextStyle(color: Colors.blue)),
                ],
              ),

              SizedBox(height: 20),

              // Login Button
              GradientButton(text: "Login", onPressed: () => loginController.login()),

              SizedBox(height: 10),

              Text("or", style: TextStyle(color: Colors.grey)),

              SizedBox(height: 10),

              // Login with OTP
              GradientButton(text: "Login with OTP", onPressed: () {}),

              SizedBox(height: 10),

              // Login with Google
              // ElevatedButton.icon(
              //   onPressed: () {},
              //   icon: Image.asset("assets/images/google.png", width: 24),
              //   label: Text("Login with Google"),
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: Colors.white,
              //     foregroundColor: Colors.black,
              //     elevation: 2,
              //     padding: EdgeInsets.symmetric(vertical: 12),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
