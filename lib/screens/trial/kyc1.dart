import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payansh/screens/trial/color.dart';
import 'package:payansh/screens/trial/kyc_controller.dart';

class KycFormScreen extends StatelessWidget {
  final KycController kycController = Get.put(KycController());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text("KYC Form"),
        // backgroundColor: TColors.primary,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            gradient: isDarkMode
                ? TColors.linearGradientdark
                : TColors.linearGradientlight,
          ),
          child: Card(
            color: isDarkMode ? TColors.darkContainer : TColors.lightContainer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Complete Your KYC",
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: isDarkMode ? TColors.textaccent : TColors.textprimary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: "Customer Identifier (Email)",
                        prefixIcon: const Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        fillColor: isDarkMode ? TColors.dark : TColors.light,
                        filled: true,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your email";
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return "Enter a valid email address";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: "Customer Name",
                        prefixIcon: const Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        fillColor: isDarkMode ? TColors.dark : TColors.light,
                        filled: true,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your name";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    Obx(() {
                      return kycController.isLoading.value
                          ? const Center(child: CircularProgressIndicator())
                          : SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: TColors.primary,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    kycController.submitKycForm(
                                      customerIdentifier:
                                          emailController.text.trim(),
                                      customerName: nameController.text.trim(),
                                    );
                                  }
                                },
                                child: Text(
                                  "Submit",
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    color: TColors.accent,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            );
                    }),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
