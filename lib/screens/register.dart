import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payansh/controllers/signup_controller.dart';
import 'package:payansh/theme/custom_themes/text_theme.dart';
import 'package:payansh/utils/snackbar_util.dart';
import 'package:payansh/widgets/CustomEmailTextField.dart';
import 'package:payansh/widgets/CustomPasswordTextField.dart';
import 'package:payansh/widgets/custom_text_field.dart';
import 'package:payansh/widgets/gradient_button.dart';
import 'package:payansh/widgets/mobile_field.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final RxBool isPasswordVisible = false.obs;

  final SignupController signupController = Get.put(SignupController());

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  void _registerUser() {
    if (passwordController.text != confirmPasswordController.text) {
      showSnackbar(
        title: "Error",
        message: "Passwords do not match",
        isSuccess: false,
      );
      return;
    }

    signupController.signup(
      nameController.text,
      emailController.text,
      passwordController.text,
      phoneController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Center(
                child: Text(
                  "Create Your Account",
                  style: TTextTheme.lightTextTheme.headlineMedium,
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  "Your Gateway to Easy Payments & Seamless Bookings!",
                  textAlign: TextAlign.center,
                  style: TTextTheme.lightTextTheme.bodyMedium,
                ),
              ),
              const SizedBox(height: 30),
              CustomTextField(
                  hintText: "Enter your name as per ID proof",
                  controller: nameController,
                  icon: Icons.person_outline),
              const SizedBox(height: 20),
              CustomEmailTextField(
                  hintText: "Enter your email",
                  controller: emailController,
                  icon: Icons.mail_outline),
              const SizedBox(height: 15),
              CustomPasswordTextField(
                hintText: "Enter your password",
                controller: passwordController,
                isPasswordVisible: isPasswordVisible,
                togglePasswordVisibility: () =>
                    isPasswordVisible.value = !isPasswordVisible.value,
                showValidations: true,
              ),
              const SizedBox(height: 15),
              CustomTextField(
                  hintText: "Confirm your password",
                  controller: confirmPasswordController,
                  icon: Icons.lock_outline_rounded),
              const SizedBox(height: 15),
              MobileNumberField(controller: phoneController),
              const SizedBox(height: 20),
              Obx(() => signupController.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : GradientButton(
                      text: "Create Account", onPressed: _registerUser)),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
