import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts
import 'package:payansh/constants/app_colors.dart';

class CustomAppBarKYC extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String description;
  final bool showBackButton;

  const CustomAppBarKYC({
    Key? key,
    required this.title,
    required this.description,
    this.showBackButton = true, // Default: Show back button
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 152,
      child: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.appBarGradient,
        ),
        padding: const EdgeInsets.fromLTRB(20, 65, 20, 10), // Adjusted padding
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // mainAxisAlignment: MainAxisAlignment.start, // Align items in center
          children: [
            Row(
                      crossAxisAlignment: CrossAxisAlignment.start, // Aligns text to the top

              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  padding: EdgeInsets.zero, // Remove extra padding
                  icon: const Icon(Icons.arrow_back,
                      color: Colors.white, size: 24),
                  onPressed: () {
                    Navigator.pop(context); // Go back when pressed
                  },
                ),
                          SizedBox(width: 8), // Adds spacing between icon & text

                Column(
                              crossAxisAlignment: CrossAxisAlignment.start, // Aligns text to left
                              mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.25,
                        color: Colors.white,
                        height: 1.25, // Line height (20px / 16px)
                      ),
                    ),
                    Text(
                  description,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.25,
                    color: Colors.white70,
                    height: 1.67, // Line height (20px / 12px)
                  ),
                ),
                  ],
                ),
                // const SizedBox(height: 4),
                
              ],
            ),

            // const SizedBox(width: 10), // Spacing

            // 📌 Title & Description (Aligned with Back Button)
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(152);
}
