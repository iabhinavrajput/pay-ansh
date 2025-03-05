import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payansh/constants/dimensions.dart';
import 'package:payansh/controllers/auth_controller.dart';
import 'package:payansh/controllers/slider_controller.dart';
import 'package:payansh/screens/forgot_password.dart';
import 'package:payansh/screens/recharge_bills.dart';
import 'package:payansh/screens/register.dart';
import 'package:payansh/services/google_sign_in_service.dart';
import 'package:payansh/theme/custom_themes/text_theme.dart';
import 'package:payansh/widgets/CustomEmailTextField.dart';
import 'package:payansh/widgets/CustomPasswordTextField.dart';
import '../widgets/gradient_button.dart';

class LoginScreen extends StatelessWidget {
  final SliderController sliderController = Get.put(SliderController());
  final AuthController authController = Get.put(AuthController());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RxBool isPasswordVisible = false.obs;

    return Scaffold(
      backgroundColor: Colors.white,

      resizeToAvoidBottomInset: false, // Prevents overflow due to keyboard
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: Dimensions.dynamicWidth(context, 0.75),
                maxHeight: constraints.maxHeight, // Use available screen height
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("WELCOME TO",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Image.asset('assets/images/logo.png',
                      width: Dimensions.dynamicWidth(context, 0.5)),
                  SizedBox(height: Dimensions.dynamicHeight(context, 0.02)),

                  // Image Slider inside Expanded to avoid overflow
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CarouselSlider(
                          options: CarouselOptions(
                            height: Dimensions.dynamicHeight(context, 0.25),
                            autoPlay: true,
                            autoPlayInterval: const Duration(seconds: 2),
                            enlargeCenterPage: true,
                            onPageChanged: (index, reason) {
                              sliderController.updateIndex(index);
                            },
                          ),
                          items: sliderController.sliderImages.map((imagePath) {
                            return Image.asset(imagePath);
                          }).toList(),
                        ),
                        SizedBox(
                            height: Dimensions.dynamicHeight(context, 0.02)),
                        Obx(() => Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                sliderController.sliderImages.length,
                                (index) => Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color:
                                        sliderController.currentIndex.value ==
                                                index
                                            ? Colors.blue
                                            : Colors.grey,
                                  ),
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                  SizedBox(height: Dimensions.dynamicHeight(context, 0.02)),

                  // Input fields inside Expanded
                  Expanded(
                    flex: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomEmailTextField(
                          controller: emailController,
                          hintText: "Enter Your Email or Phone",
                          icon: Icons.person,
                        ),
                        SizedBox(
                            height: Dimensions.dynamicHeight(context, 0.015)),
                        CustomPasswordTextField(
                          controller: passwordController,
                          hintText: "Enter your password",
                          isPasswordVisible: isPasswordVisible,
                          togglePasswordVisibility: () => isPasswordVisible
                              .value = !isPasswordVisible.value,
                          showValidations: false,
                        ),
                        SizedBox(
                            height: Dimensions.dynamicHeight(context, 0.01)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Checkbox(value: true, onChanged: (value) {}),
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
                        SizedBox(
                            height: Dimensions.dynamicHeight(context, 0.02)),
                        Obx(() => authController.isLoading.value
                            ? const CircularProgressIndicator()
                            : GradientButton(
                                text: "Login",
                                onPressed: () async {
                                  await authController.login(
                                      emailController.text,
                                      passwordController.text);
                                },
                              )),
                        SizedBox(
                            height: Dimensions.dynamicHeight(context, 0.01)),
                        const Text("or", style: TextStyle(color: Colors.grey)),
                        SizedBox(
                            height: Dimensions.dynamicHeight(context, 0.01)),
                        GradientButton(
                            text: "Login with OTP",
                            onPressed: () {
                              Get.to(() => RechargeBillPage());
                            }),
                        SizedBox(
                            height: Dimensions.dynamicHeight(context, 0.01)),
                      ],
                    ),
                  ),

                  // Sign up section
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            final user =
                                await GoogleSignInService.signInWithGoogle();
                            if (user != null) {
                              print("$user");
                              print("Login successful: $user");
                            } else {
                              print("Login failed or cancelled.");
                            }
                          },
                          child: Text(
                            "Don't have an account? ",
                            style: TTextTheme.lightTextTheme.labelLarge,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.to(() => const Register());
                          },
                          style: ButtonStyle(
                            padding: WidgetStateProperty.all(EdgeInsets.zero),
                          ),
                          child: const Text(
                            "Sign Up",
                            style: TTextTheme.link,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
