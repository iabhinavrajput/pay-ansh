import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payansh/controllers/auth_controller.dart';
import 'package:payansh/screens/forgot_password.dart';
import 'package:payansh/screens/register.dart';
import 'package:payansh/theme/custom_themes/text_theme.dart';
import 'package:payansh/widgets/CustomEmailTextField.dart';
import 'package:payansh/widgets/CustomPasswordTextField.dart';
import 'package:payansh/widgets/custom_text_field.dart';
import '../constants/app_colors.dart';
import '../widgets/gradient_button.dart';
import '../services/api_service.dart';
import '../utils/local_storage.dart';

class LoginScreen extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final RxBool isPasswordVisible = false.obs;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(47),
          child: Column(
            children: [
              const Text("WELCOME TO",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),

              // Logo
              Image.asset('assets/images/logo.png', width: screenWidth * 0.5),

              const SizedBox(height: 20),

              // Illustration
              Image.asset('assets/images/login.png', width: screenWidth * 0.8),

              const SizedBox(height: 20),

              // Email Input
              CustomEmailTextField(
                controller: emailController,
                hintText: "Enter Your Email or Phone",
                icon: Icons.person,
              ),
              const SizedBox(height: 15),

              // Password Input
              // Password Input Field
              CustomPasswordTextField(
                controller: passwordController,
                hintText: "Enter your password",
                isPasswordVisible: isPasswordVisible,
                togglePasswordVisibility: () =>
                    isPasswordVisible.value = !isPasswordVisible.value,
                showValidations: false, // No validations in login screen
                // Toggle visibility
              ),

              const SizedBox(height: 10),

              // Remember Me & Forgot Password
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(value: false, onChanged: (value) {}),
                      const Text("Remember me"),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => Get.to(() => ForgotPasswordScreen()),
                    child: const Text("Forgot Password?",
                        style: TextStyle(color: Colors.blue)),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Login Button
              Obx(() => authController.isLoading.value
                  ? const CircularProgressIndicator()
                  : GradientButton(
                      text: "Login",
                      onPressed: () async {
                        await authController.login(
                            emailController.text, passwordController.text);
                      },
                    )),

              const SizedBox(height: 10),

              const Text("or", style: TextStyle(color: Colors.grey)),

              const SizedBox(height: 10),

              // Login with OTP
              GradientButton(text: "Login with OTP", onPressed: () {}),

              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't you have an account? ",
                    style: TTextTheme.lightTextTheme.labelLarge,
                  ),
                  TextButton(
                    onPressed: () {
                      // Navigate to Sign Up
                      Get.off(() => Register());
                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                          EdgeInsets.zero), // Remove padding
                    ),
                    child: const Text(
                      "Sign Up",
                      style: TTextTheme.link,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
