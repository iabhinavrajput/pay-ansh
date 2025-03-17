import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payansh/constants/dimensions.dart';
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
  final RxBool isConfirmPasswordVisible =
      false.obs; // Separate visibility controller
  final RxBool isFormValid = false.obs;

  final SignupController signupController = Get.put(SignupController());

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final RxBool isNameValid = false.obs;
  final RxBool isEmailValid = false.obs;
  final RxBool isPasswordValid = false.obs;
  final RxBool isConfirmPasswordValid = false.obs;
  final RxBool isPhoneValid = false.obs;

  @override
  void initState() {
    super.initState();

    // Add listener for name field validation
    nameController.addListener(() {
      isNameValid.value = nameController.text.isNotEmpty;
      print(
          "Name field updated: ${nameController.text}, Valid: ${isNameValid.value}");
      updateFormValidity();
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();
    Get.delete<
        SignupController>(); // Delete controller instance if not needed globally

    super.dispose();
  }

  void updateFormValidity() {
    print("Updating form validity:");
    print("Name Valid: ${isNameValid.value}");
    print("Email Valid: ${isEmailValid.value}");
    print("Password Valid: ${isPasswordValid.value}");
    print("Confirm Password Valid: ${isConfirmPasswordValid.value}");
    print("Phone Valid: ${isPhoneValid.value}");

    isFormValid.value = isNameValid.value &&
        isEmailValid.value &&
        isPasswordValid.value &&
        isConfirmPasswordValid.value &&
        isPhoneValid.value;
    print("Form Valid: ${isFormValid.value}");
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

    if (!isFormValid.value) return;

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
          padding:  EdgeInsets.symmetric(horizontal: Dimensions.dynamicHeight(context, 0.05)),
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
                hintText: "Enter name as per ID proof",
                controller: nameController,
                icon: Icons.person_outline,
              ),
              const SizedBox(height: 20),
              CustomEmailTextField(
                hintText: "Enter your email",
                controller: emailController,
                icon: Icons.mail_outline,
                onValidationChanged: (isValid) {
                  isEmailValid.value = isValid;
                  print("Email Valid: $isValid");

                  updateFormValidity();
                },
              ),
              const SizedBox(height: 15),
              CustomPasswordTextField(
                hintText: "Enter your password",
                controller: passwordController,
                isPasswordVisible: isPasswordVisible,
                togglePasswordVisibility: () =>
                    isPasswordVisible.value = !isPasswordVisible.value,
                showValidations: true,
                onValidationChanged: (isValid) {
                  isPasswordValid.value = isValid;
                  print("Password Valid: $isValid");

                  // Revalidate confirm password when password changes
                  isConfirmPasswordValid.value = confirmPasswordController
                          .text.isNotEmpty &&
                      confirmPasswordController.text == passwordController.text;
                  print(
                      "Confirm Password Valid (on password change): ${isConfirmPasswordValid.value}");

                  updateFormValidity();
                },
              ),
              const SizedBox(height: 15),
              CustomPasswordTextField(
                hintText: "Confirm your password",
                controller: confirmPasswordController,
                isPasswordVisible: isConfirmPasswordVisible,
                togglePasswordVisibility: () => isConfirmPasswordVisible.value =
                    !isConfirmPasswordVisible.value,
                showValidations: true,
                onValidationChanged: (_) {
                  isConfirmPasswordValid.value = confirmPasswordController
                          .text.isNotEmpty &&
                      confirmPasswordController.text == passwordController.text;
                  print(
                      "Confirm Password Valid (on confirm password change): ${isConfirmPasswordValid.value}");
                  updateFormValidity();
                },
              ),
              const SizedBox(height: 15),
              MobileNumberField(
                controller: phoneController,
                onChanged: (value) {
                  isPhoneValid.value = RegExp(r'^\d{10}$').hasMatch(value);
                  print("Phone Valid: ${isPhoneValid.value}");

                  updateFormValidity();
                },
              ),
              const SizedBox(height: 20),
              Obx(() => signupController.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : Obx(() => GradientButton(
                        text: "Create Account",
                        onPressed: isFormValid.value ? _registerUser : null,
                        isEnabled: isFormValid.value,
                      ))),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
