import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payansh/routes/routes.dart';
import 'package:payansh/widgets/app_bar.dart';
import '../utils/local_storage.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> logout() async {
    await LocalStorage.clearUserToken();
    Get.offAllNamed(AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          // AppBar
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 750,
            child: CustomAppBar(height: 50), // Increase height for overlap
          ),

          // Profile Section (Overlapping AppBar)
          Positioned(
            top: 80, // Adjust to control how much it overlaps
            left: 16,
            right: 16,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.white,
                  child: Text("TU", style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Test User",
                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Welcome to Payance!",
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ],
                ),
                const Spacer(),
                Icon(Icons.notifications, color: Colors.white),
              ],
            ),
          ),

          // Main Content Below
          
        ],
      ),
    );
  }

 
}
