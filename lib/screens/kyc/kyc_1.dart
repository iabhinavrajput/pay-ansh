import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:payansh/components/custom_app_bar_kyc.dart';
import 'package:payansh/constants/app_colors.dart';

class KycOne extends StatelessWidget {
  const KycOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBarKYC(
        title: "Complete KYC",
        description: "Complete your KYC to avail the\nPayansh services",
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(height: 20,),
            Container(
              width: 120,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.helpColor,
                borderRadius: BorderRadius.circular(6),
                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.black.withOpacity(0.1),
                //   ),
                // ],
              ),
              child: Row(
                children: [
                  SvgPicture.asset('assets/kyc/help.svg'),
                  const SizedBox(width: 10),
                  const Text(
                    "Help",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40,),
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Text Content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "KYC Documents",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: Colors.black87,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                color: AppColors.kycContainerColor,
                                shape: BoxShape.circle,
                              ),
                              child: SvgPicture.asset('assets/kyc/kyc_status.svg', width: 20,),

                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {
                            // TODO: Implement document upload logic
                          },
                          child: const Text(
                            "Upload your documents",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: AppColors.gradientStart,
                              // decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          "Pending",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.pendingColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // 📄 Document Icon
                ],
              ),
            ),

            // const Spacer(),
            const SizedBox(height: 40),

            // 🚀 Proceed Button
            SizedBox(
              width: double.infinity,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: AppColors
                      .appBarGradient, // 🔹 Gradient from your constants
                  borderRadius: BorderRadius.all(
                      Radius.circular(12)), // 🔹 Rounded corners
                ),
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Implement proceed action
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors
                        .transparent, // 🔹 Makes button background transparent
                    shadowColor:
                        Colors.transparent, // 🔹 Removes default button shadow
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(12), // 🔹 Ensures corners match
                    ),
                  ),
                  child: const Text(
                    "Proceed",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
