import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:payansh/routes/routes.dart';
import 'package:payansh/services/api_service.dart';
import 'package:payansh/services/auth_service.dart';
import 'package:payansh/widgets/sidebar_menu_item.dart';

class DrawerNavigation extends StatefulWidget {
  const DrawerNavigation({Key? key}) : super(key: key);

  @override
  _DrawerNavigationState createState() => _DrawerNavigationState();
}

class _DrawerNavigationState extends State<DrawerNavigation> {
  late Future<Map<String, dynamic>?> _userProfileFuture;

  @override
  void initState() {
    super.initState();
    _userProfileFuture = ApiService.getUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250, // Sidebar width
      color: Colors.white,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder<Map<String, dynamic>?>(
              future: _userProfileFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError || !snapshot.hasData) {
                  return const Center(child: Text("Failed to load profile"));
                }

                final userData = snapshot.data!;
                return Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage:
                            NetworkImage(userData['profile_picture']),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        userData['name'],
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        userData['phone'],
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton.icon(
                        onPressed: () {
                          Get.toNamed(AppRoutes.profileScreen);
                        },
                        icon: const Icon(Icons.person, size: 16),
                        label: const Text("View Profile"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.blue,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(color: Colors.blue),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 30),
            const Text("Account Management",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const SidebarMenuItem(
              icon: Icons.verified_user,
              title: "KYC Status",
              subtitle: "⚠ KYC Incomplete",
              subtitleColor: Colors.red,
            ),
            const SidebarMenuItem(
              icon: Icons.settings,
              title: "App Settings & Info",
              subtitle: "Change app settings",
            ),
            const SidebarMenuItem(
              icon: Icons.local_offer,
              title: "Cashback & Offers",
              subtitle: "Show all the Offers",
            ),
            const SidebarMenuItem(
              icon: Icons.help_outline,
              title: "Have a Complaint?",
              subtitle: "Raise a complaint",
            ),
            const SidebarMenuItem(
              icon: Icons.delete_forever,
              title: "Delete Account",
              subtitle: "Delete account from Payance",
            ),
            SidebarMenuItem(
              icon: Icons.logout,
              title: "Logout",
              subtitle: "Do you want to logout",
              onTap: () {
                Get.defaultDialog(
                  title: "Logout",
                  middleText: "Do you want to logout?",
                  textConfirm: "Yes",
                  textCancel: "No",
                  confirmTextColor: Colors.white,
                  buttonColor: Colors.blue,
                  onConfirm: () {
                    AuthService.logout(context);
                  },
                );
              },
            ),
            const SizedBox(height: 20),
            const Center(
              child: Text("Version 3.2",
                  style: TextStyle(color: Colors.grey, fontSize: 14)),
            ),
          ],
        ),
      ),
    );
  }
}
