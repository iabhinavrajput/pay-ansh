import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:payansh/controllers/auth_controller.dart';
import 'package:payansh/screens/forgot_password.dart';
import 'package:payansh/screens/recharge_bills.dart';
import 'package:payansh/screens/register.dart';
import 'package:payansh/theme/custom_themes/text_theme.dart';
import 'package:payansh/widgets/CustomEmailTextField.dart';
import 'package:payansh/widgets/CustomPasswordTextField.dart';
import 'package:payansh/widgets/gradient_button.dart';

class LoginScreen extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

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
              const Text("WELCOME TO", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),

              Image.asset('assets/images/logo.png', width: screenWidth * 0.5),
              const SizedBox(height: 20),
              Image.asset('assets/images/login.png'),
              const SizedBox(height: 20),

              CustomEmailTextField(controller: emailController, hintText: "Enter Your Email or Phone", icon: Icons.person),
              const SizedBox(height: 15),

              CustomPasswordTextField(
                controller: passwordController,
                hintText: "Enter your password",
                isPasswordVisible: isPasswordVisible,
                togglePasswordVisibility: () => isPasswordVisible.value = !isPasswordVisible.value,
                showValidations: false,
              ),

              const SizedBox(height: 10),

              // Remember Me & Forgot Password Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(() => Row(
                        children: [
                          Checkbox(
                            value: authController.isRememberMe.value,
                            onChanged: (value) {
                              authController.toggleRememberMe(value!);
                            },
                          ),
                          const Text("Remember me"),
                        ],
                      )),
                  GestureDetector(
                    onTap: () => Get.to(() => ForgotPasswordScreen()),
                    child: const Text("Forgot Password?", style: TextStyle(color: Colors.blue)),
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
                        await authController.login(emailController.text, passwordController.text);
                      },
                    )),

              const SizedBox(height: 10),

              const Text("or", style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 10),

              GradientButton(
                text: "Login with OTP",
                onPressed: () {
                  Get.to(() => RechargeBillPage());
                },
              ),

              const SizedBox(height: 10),

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?", style: TTextTheme.lightTextTheme.labelLarge),
                  TextButton(
                    onPressed: () => Get.to(() => const Register()),
                    style: ButtonStyle(padding: WidgetStateProperty.all(EdgeInsets.zero)),
                    child: const Text("Sign Up", style: TTextTheme.link),
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
