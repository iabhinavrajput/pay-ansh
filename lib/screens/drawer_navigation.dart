import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:payansh/constants/app_colors.dart';
import 'package:payansh/screens/kyc/kyc_1.dart';
import 'package:payansh/screens/complaint/complaint_screen.dart';
import 'package:payansh/screens/trial/kyc1.dart';
import 'package:shimmer/shimmer.dart';
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
  String _appVersion = "Loading...";

  @override
  void initState() {
    super.initState();
    _userProfileFuture = ApiService.getUserProfile().then((response) {
      print("User Profile Response: $response");
      return response;
    });

    _getAppVersion();
  }

  Future<void> _getAppVersion() async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      if (mounted) {
        setState(() {
          _appVersion = "Version ${packageInfo.version}";
        });
      }
    } catch (e) {
      print("Error getting app version: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      width: 340,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder<Map<String, dynamic>?>(
              future: _userProfileFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return _buildShimmerEffect();
                } else if (snapshot.hasError || !snapshot.hasData) {
                  return const Center(child: Text("Failed to load profile"));
                }
                final userData = snapshot.data!;
                return _buildUserProfile(userData);
              },
            ),
            const SizedBox(height: 20),
            _buildMenuItems(),
            const SizedBox(height: 20),
            Center(
              child: Text(
                _appVersion.isEmpty ? "Fetching Version..." : _appVersion,
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 📌 Shimmer Skeleton Loader
  Widget _buildShimmerEffect() {
    return Center(
      child: Container(
        width: 340,
        padding: const EdgeInsets.fromLTRB(30, 25, 30, 24),
        decoration: const BoxDecoration(
          gradient: AppColors.drawerColourUser,
        ),
        child: Column(
          children: [
            _shimmerBox(width: 60, height: 60, radius: 10),
            const SizedBox(height: 10),
            _shimmerBox(width: 100, height: 16),
            const SizedBox(height: 5),
            _shimmerBox(width: 80, height: 14),
            const SizedBox(height: 10),
            _shimmerBox(width: 120, height: 35, radius: 10),
          ],
        ),
      ),
    );
  }

  // 📌 User Profile UI
  Widget _buildUserProfile(Map<String, dynamic> userData) {
    return Center(
      child: Container(
        width: 340,
        padding: const EdgeInsets.fromLTRB(30, 25, 30, 24),
        decoration: const BoxDecoration(
          gradient: AppColors.drawerColourUser,
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                userData['profile_picture'] ?? '',
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                    gradient: AppColors.userLetterBg,
                  ),
                  // color:  AppColors.userLetterBg,
                  alignment: Alignment.center,
                  child: Text(
                    userData['name'][0].toUpperCase(),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              userData['name'],
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (userData['phone'] != null &&
                    userData['phone'].toString().isNotEmpty) ...[
                  const Text('+91 ', style: TextStyle(color: Colors.grey)),
                  Text(userData['phone'],
                      style: const TextStyle(color: Colors.grey)),
                ]
              ],
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () {
                Get.toNamed(AppRoutes.profileScreen);
              },
              icon: const Icon(
                Icons.person,
                size: 18,
                color: AppColors.drawerTextColor,
              ),
              label: const Text("View Profile"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: AppColors.drawerTextColor,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  // side: const BorderSide(color: Colors.blue),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 📌 Sidebar Menu Items
  Widget _buildMenuItems() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.0),
            child: Text("Account Management",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 10),
          SidebarMenuItem(
            icon: SvgPicture.asset('assets/drawer_navigation/idCard.svg'),
            title: "KYC Status",
            subtitle: "● KYC Incomplete",
            subtitleColor: Colors.red,
            onTap: () {
              // Get.to(KycOne());


              Get.to(KycOne());

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
              Get.to(ComplaintScreen());
            },
          ),
          SidebarMenuItem(
            icon: SvgPicture.asset('assets/drawer_navigation/person.svg'),
            title: "Delete Account",
            subtitle: "Delete account from Payance",
            onTap: () async {
                await AuthController.deleteAccountInitiate(context);
            },
          ),
          SidebarMenuItem(
            icon: SvgPicture.asset('assets/drawer_navigation/logout.svg'),
            title: "Logout",
            subtitle: "Do you want to logout?",
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
        ],
      ),
    );
  }

  // 📌 Helper function: Shimmer Box
  Widget _shimmerBox(
      {required double width, required double height, double radius = 4}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }

  // 📌 Helper function: Box Decoration
//   BoxDecoration _boxDecoration() {
//     return const BoxDecoration(
//       gradient: LinearGradient(
//         colors: [Color.fromRGBO(70, 134, 197, 0.12), Color.fromRGBO(65, 194, 236, 0.20)],
//       ),
//       // boxShadow: [BoxShadow(color: Color.fromRGBO(70, 134, 197, 0.08), offset: Offset(2, 8), blurRadius: 10)],
//     );
//   }
}
