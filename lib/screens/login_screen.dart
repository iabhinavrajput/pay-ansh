import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payansh/constants/app_colors.dart';
import 'package:payansh/constants/dimensions.dart';
import 'package:payansh/controllers/auth_controller.dart';
import 'package:payansh/controllers/remember_me.dart';
import 'package:payansh/controllers/slider_controller.dart';
import 'package:payansh/screens/forgot_password.dart';
import 'package:payansh/screens/recharge_bills.dart';
import 'package:payansh/screens/register.dart';
import 'package:payansh/services/google_sign_in_service.dart';
import 'package:payansh/theme/custom_themes/text_theme.dart';
import 'package:payansh/widgets/CustomEmailTextField.dart';
import 'package:payansh/widgets/CustomPasswordTextField.dart';
import 'package:payansh/widgets/google_btn.dart';
import '../widgets/gradient_button.dart';

class LoginScreen extends StatelessWidget {
  final RememberMeController rememberMeController =
      Get.put(RememberMeController());

  final SliderController sliderController = Get.put(SliderController());
  final AuthController authController = Get.put(AuthController());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final RxBool isEmailValid = false.obs;
  final RxBool isPasswordValid = false.obs;
  final RxBool isPasswordVisible = false.obs;

  LoginScreen({super.key}) {
    // Prefill stored credentials
    emailController.text = rememberMeController.savedEmail;
    passwordController.text = rememberMeController.savedPassword;
  }

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
                // maxHeight: constraints.maxHeight, // Use available screen height
              ),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: Dimensions.dynamicHeight(context, 0.05),
                  ),
                  const Text("WELCOME TO",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Image.asset('assets/images/logo.png',
                      width: Dimensions.dynamicWidth(context, 0.5)),
                  SizedBox(height: Dimensions.dynamicHeight(context, 0.02)),

                  // Image Slider inside Expanded to avoid overflow

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
                  SizedBox(height: Dimensions.dynamicHeight(context, 0.01)),
                  Obx(() => Stack(
                        children: [
                          DotsIndicator(
                            dotsCount: sliderController.sliderImages.length,
                            position:
                                sliderController.currentIndex.value.toDouble(),
                            decorator: DotsDecorator(
                              spacing:
                                  const EdgeInsets.symmetric(horizontal: 2.0),
                              color: AppColors.primaryBackground,
                              activeColor: Colors.transparent,
                              size: Size.square(
                                  Dimensions.dynamicHeight(context, 0.006)),
                              activeSize: Size(20.0,
                                  Dimensions.dynamicHeight(context, 0.006)),
                              activeShape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                            ),
                          ),
                          Positioned(
                            left: sliderController.currentIndex.value * 11.5,
                            child: Container(
                              width: 20.0,
                              height: Dimensions.dynamicHeight(context, 0.006),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    AppColors.gradientStart,
                                    AppColors.gradientEnd
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                          ),
                        ],
                      )),

                  SizedBox(height: Dimensions.dynamicHeight(context, 0.02)),

                  // Input Fields & Buttons (Using IntrinsicHeight for natural sizing)

                  CustomEmailTextField(
                    controller: emailController,
                    hintText: "Enter Your Email",
                    icon: Icons.person_outline,
                    onValidationChanged: (isValid) {
                      isEmailValid.value = isValid;
                      print("Email Valid: $isValid");
                    },
                  ),
                  SizedBox(height: Dimensions.dynamicHeight(context, 0.015)),
                  CustomPasswordTextField(
                    controller: passwordController,
                    hintText: "Enter your password",
                    isPasswordVisible: isPasswordVisible,
                    togglePasswordVisibility: () =>
                        isPasswordVisible.value = !isPasswordVisible.value,
                    showValidations: false,
                    onValidationChanged: (isValid) {
                      isPasswordValid.value = isValid;
                      print("Password Valid: $isValid");
                    },
                  ),
                  SizedBox(height: Dimensions.dynamicHeight(context, 0.01)),

                  // Remember Me & Forgot Password
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Obx(() => GestureDetector(
                                onTap: () {
                                  rememberMeController.toggleRememberMe(
                                      !rememberMeController.isRemembered.value);
                                },
                                child: Container(
                                  width:
                                      Dimensions.dynamicHeight(context, 0.02),
                                  height:
                                      Dimensions.dynamicHeight(context, 0.02),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                    border: Border.all(color: Colors.grey),
                                    gradient:
                                        rememberMeController.isRemembered.value
                                            ? LinearGradient(
                                                colors: [
                                                  AppColors.gradientStart,
                                                  AppColors.gradientEnd
                                                ],
                                              )
                                            : null,
                                    color:
                                        rememberMeController.isRemembered.value
                                            ? null
                                            : Colors.transparent,
                                  ),
                                  child: rememberMeController.isRemembered.value
                                      ? const Icon(Icons.check,
                                          color: Colors.white, size: 18)
                                      : null,
                                ),
                              )),
                          const SizedBox(width: 8),
                          const Text("Remember me"),
                        ],
                      ),
                      GestureDetector(
                        onTap: () => Get.to(() => ForgotPasswordScreen()),
                        child: const Text("Forgot Password?"),
                      ),
                    ],
                  ),
                  SizedBox(height: Dimensions.dynamicHeight(context, 0.02)),

                  // Login Button
                  Obx(() => authController.isLoading.value
                      ? const CircularProgressIndicator()
                      : GradientButton(
                          text: "Login",
                          onPressed:
                              (isEmailValid.value && isPasswordValid.value)
                                  ? () {
                                      authController.login(emailController.text,
                                          passwordController.text);
                                      rememberMeController.saveCredentials(
                                          emailController.text,
                                          passwordController.text);
                                    }
                                  : () {},
                          isEnabled:
                              isEmailValid.value && isPasswordValid.value,
                        )),
                  SizedBox(height: Dimensions.dynamicHeight(context, 0.01)),
                  const Text("or", style: TextStyle(color: Colors.grey)),
                  SizedBox(height: Dimensions.dynamicHeight(context, 0.01)),

                  // Fix Overflow: Using Column and Spacer

                  GradientButton(
                    text: "Login with Phone number",
                    onPressed: () {
                      Get.to(() => RechargeBillPage());
                    },
                  ),
                  SizedBox(height: Dimensions.dynamicHeight(context, 0.02)),
                  SizedBox(
                    height: Dimensions.dynamicHeight(
                        context, 0.06), // Adjust as needed
                    child: GoogleBtn(),
                  ),

                  // Spacer(), // Pushes Sign Up Section to the bottom

                  // Sign-up Section
                  SizedBox(
                    height: Dimensions.dynamicHeight(context, 0.015),
                  ),
                  FittedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            final user =
                                await GoogleSignInService.signInWithGoogle();
                            if (user != null) {
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
                  )

                  // SizedBox(height: Dimensions.dynamicHeight(context, 0.02)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
