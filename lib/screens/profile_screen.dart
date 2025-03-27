import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:payansh/constants/app_colors.dart';
import 'package:payansh/constants/dimensions.dart';
import 'package:payansh/services/auth_service.dart';
import 'package:payansh/theme/custom_themes/text_theme.dart';
import 'package:payansh/widgets/app_bar.dart';
import 'package:payansh/widgets/profile_item_widget.dart';
import 'package:payansh/services/api_service.dart';
import 'package:shimmer/shimmer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<Map<String, dynamic>?> _profileFuture;

  @override
  void initState() {
    super.initState();
    _profileFuture = ApiService.getUserProfile();
  }

  Widget _buildShimmerEffect() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        children: [
          SizedBox(height: Dimensions.dynamicHeight(context, 0.14)),
          CircleAvatar(radius: 40, backgroundColor: Colors.white),
          SizedBox(height: 10),
          Container(
              height: 20,
              width: 120,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10))),
          SizedBox(height: 5),
          Container(
              height: 15,
              width: 180,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10))),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.dynamicHeight(context, 0.02),
            ),
            child: Column(
              children: List.generate(3, (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Container(
                    height: 55,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<Map<String, dynamic>?>(
        future: _profileFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildShimmerEffect();
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text("Failed to load profile"));
          } else {
            final userData = snapshot.data!;
            final userName = userData['name'] ?? 'No Name';
            final userPhone = userData['phone'] ?? 'No Phone';
            final userEmail = userData['email'] ?? 'No Email';
            final profilePicture = userData['profile_picture'] ?? '';
            final ismailverified = userData['email_verified'] ?? 0;
            final isphonelverified = userData['phone_verified'] ?? 0;

            return SingleChildScrollView(
                child: Column(children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  SizedBox(
                    height: Dimensions.dynamicHeight(context, 0.14),
                    child: CustomAppBar(height: 0),
                  ),
                  Positioned(
                    top: Dimensions.dynamicHeight(context, 0.07),
                    left: 10,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Positioned(
                    top: Dimensions.dynamicHeight(context, 0.07),
                    right: 10,
                    child: IconButton(
                      icon: const Icon(Icons.logout, color: Colors.white),
                      onPressed: () {
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
                  ),
                  Positioned(
                    top: Dimensions.dynamicHeight(context, 0.07),
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: Dimensions.dynamicWidth(context, 0.3),
                            height: Dimensions.dynamicWidth(context, 0.3),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 10,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: profilePicture.isNotEmpty &&
                                      Uri.tryParse(profilePicture)
                                              ?.hasAbsolutePath ==
                                          true
                                  ? Image.network(
                                      profilePicture,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return SvgPicture.asset(
                                            'assets/profile/profile.svg',
                                            fit: BoxFit.cover);
                                      },
                                    )
                                  : SvgPicture.asset(
                                      'assets/profile/profile.svg',
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: Dimensions.dynamicHeight(context, 0.08)),
              Text(userName, style: TTextTheme.lightTextTheme.titleSmall),
              Text(userPhone, style: TTextTheme.lightTextTheme.bodyMedium),
              const SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.dynamicHeight(context, 0.02),
                ),
                child: Column(
                  children: [
                    ProfileItemWidget(
                      icon: Icons.person,
                      label: "Name",
                      value: userName,
                      onEdit: () {},
                    ),
                    ProfileItemWidget(
                      icon: Icons.phone,
                      label: "Contact Number",
                      value: userPhone,
                      onEdit: () {},
                      verified: isphonelverified,
                    ),
                    ProfileItemWidget(
                      icon: Icons.email,
                      label: "Email ID",
                      value: userEmail,
                      onEdit: () {},
                      verified: ismailverified,
                    ),
                  ],
                ),
              )
            ]));
          }
        },
      ),
    );
  }
}
