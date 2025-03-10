import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:payansh/controllers/auth_controller.dart';
import 'package:payansh/routes/routes.dart';
import 'package:payansh/services/api_service.dart';
import 'package:payansh/services/auth_service.dart';
import 'package:payansh/widgets/sidebar_menu_item.dart';


class DrawerNavigation extends StatefulWidget {
  @override
  State<DrawerNavigation> createState() => _DrawerNavigationState();
}

class _DrawerNavigationState extends State<DrawerNavigation> {
  late final Future<Map<String, dynamic>?> _userProfileFuture;

  @override
  void initState() {
    super.initState();
    _userProfileFuture = ApiService.getUserProfile().then((response) {
      print("User Profile Response: $response");
      return response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 340, // Sidebar width
      // color: Colors.white,
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
             SidebarMenuItem(
              icon: SvgPicture.asset('assets/drawer_navigation/idCard.svg'), 
              title: "KYC Status",
              subtitle: "⚠ KYC Incomplete",
              subtitleColor: Colors.red,
              onTap: () {
              },
            ),
             SidebarMenuItem(
              icon: SvgPicture.asset('assets/drawer_navigation/setting.svg'), 
              title: "App Settings & Info",
              subtitle: "Change app settings",
              onTap: () {
                Get.toNamed(AppRoutes.appSetting);
              },
            ),
             SidebarMenuItem(
              icon: SvgPicture.asset('assets/drawer_navigation/offer.svg'), 
              title: "Cashback & Offers",
              subtitle: "Show all the Offers",
              onTap: () {
                Get.toNamed(AppRoutes.cashback);
              },
            ),
             SidebarMenuItem(
              icon: SvgPicture.asset('assets/drawer_navigation/symbol.svg'), 
              title: "Have a Complaint?",
              subtitle: "Raise a complaint",
              onTap: () {
                
              },
            ),
            SidebarMenuItem(
              icon: SvgPicture.asset(('assets/drawer_navigation/person.svg'),), 
              title: "Delete Account",
              subtitle: "Delete account from Payance",
              onTap: () {

              },
            ),
            
              SidebarMenuItem(
              icon: SvgPicture.asset('assets/drawer_navigation/logout.svg'), 
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
                  onConfirm: () async {
                    Get.back();
                    await AuthService.logout(context);
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



 









