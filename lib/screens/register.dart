import 'package:flutter/material.dart';
import 'package:payansh/widgets/custom_text_field.dart';
import 'package:payansh/widgets/gradient_button.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // Define controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  void dispose() {
    // Dispose controllers to free memory
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  "Create Your Account",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 5),
              const Center(
                child: Text(
                  "Your Gateway to Easy Payments & Seamless Bookings!",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 20),
              CustomTextField(hintText: "Enter your name as per ID proof", controller: nameController, icon: Icons.person),
              CustomTextField(hintText: "Enter your email", controller: emailController, icon: Icons.mail),
              CustomTextField(hintText: "Enter your password", controller: passwordController, icon: Icons.lock, ),
              CustomTextField(hintText: "Confirm your password", controller: confirmPasswordController, icon: Icons.lock, ),
              CustomTextField(hintText: "Mobile Number*", controller: phoneController, icon: Icons.phone),
              const SizedBox(height: 20),
              GradientButton(text: "Create Account", onPressed: () {
                // Handle form submission logic
                print("Name: ${nameController.text}");
                print("Email: ${emailController.text}");
                print("Password: ${passwordController.text}");
                print("Confirm Password: ${confirmPasswordController.text}");
                print("Phone: ${phoneController.text}");
              }),
              const SizedBox(height: 15),
              const Center(child: Text("or", style: TextStyle(fontSize: 14))),
              const SizedBox(height: 15),
              // Add Google sign-in button if needed
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
