import 'package:carousel_slider/carousel_slider.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:payansh/controllers/auth_controller.dart';
import 'package:payansh/controllers/slider_controller.dart';
import 'package:payansh/screens/animated_bottom_bar.dart';
import 'package:payansh/screens/device_info.dart';
import 'package:payansh/screens/forgot_password.dart';
import 'package:payansh/screens/home_screen.dart';
import 'package:payansh/screens/recharge_bills.dart';
import 'package:payansh/screens/register.dart';
import 'package:payansh/theme/custom_themes/text_theme.dart';
import 'package:payansh/widgets/CustomEmailTextField.dart';
import 'package:payansh/widgets/CustomPasswordTextField.dart';
import '../widgets/gradient_button.dart';
import 'recharge_bills.dart';

class LoginScreen extends StatelessWidget {
  final SliderController sliderController = Get.put(SliderController());

  final RxInt currentIndex = 0.obs;
  final List<String> sliderImages = [
    'assets/login_slider/login_slider1.svg',
    'assets/login_slider/login_slider2.svg',
    'assets/login_slider/login_slider3.svg',
  ];

  final AuthController authController = Get.put(AuthController());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

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
              // Image Slider
              CarouselSlider(
                options: CarouselOptions(
                  height: 200,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 1),
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) {
                    sliderController.updateIndex(index);
                  },
                ),
                items: sliderController.sliderImages.map((imagePath) {
                  return Image.asset(imagePath);
                }).toList(),
              ),

              const SizedBox(height: 20),

              // Dots Indicator using Obx
              Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      sliderController.sliderImages.length,
                      (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: sliderController.currentIndex.value == index
                              ? Colors.blue
                              : Colors.grey,
                        ),
                      ),
                    ),
                  )),
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
              GradientButton(
                  text: "Login with OTP",
                  onPressed: () {
                    Get.to(() => RechargeBillPage());
                  }),

              const SizedBox(height: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't you have an account? ",
                    style: TTextTheme.lightTextTheme.labelLarge,
                  ),
                  TextButton(
                    onPressed: () {
                      // Navigate to Sign Up
                      Get.to(() => const Register());
                    },
                    style: ButtonStyle(
                      padding: WidgetStateProperty.all(
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
