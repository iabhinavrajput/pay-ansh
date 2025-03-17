import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:payansh/constants/style_constants.dart';
import 'package:payansh/services/auth_service.dart';
import 'package:payansh/widgets/app_bar.dart';
import 'package:payansh/widgets/profile_item_widget.dart';
import 'package:payansh/services/api_service.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<Map<String, dynamic>?>(
        future: _profileFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
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

            return SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      const SizedBox(
                        height: 150,
                        child: CustomAppBar(height: 0),
                      ),
                      Positioned(
                        top: 20,
                        left: 10,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      Positioned(
                        top: 20,
                        right: 10,
                        child: IconButton(
                          icon: const Icon(Icons.logout, color: Colors.white),
                          onPressed: () {
                            AuthService.logout(context);
                          },
                        ),
                      ),
                      Positioned(
                        top: 80,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                width: 150,
                                height: 150,
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
                                          Uri.tryParse(profilePicture)?.hasAbsolutePath == true
                                      ? Image.network(
                                          profilePicture,
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) {
                                            return SvgPicture.asset('assets/profile/profile.svg',
                                                fit: BoxFit.cover);
                                          },
                                        )
                                      : SvgPicture.asset(
                                          'assets/profile/profile.svg',
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                              Positioned(
                                bottom: -5,
                                right: -5,
                                child: Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.white, width: 2),
                                  ),
                                  child: const Icon(Icons.edit, color: Colors.white, size: 18),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(userName, style: StyleConstants.profileNameText),
                  const SizedBox(height: 5),
                  Text(userPhone, style: StyleConstants.profilePhoneText),
                  const SizedBox(height: 20),
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
                  ),
                  ProfileItemWidget(
                    icon: Icons.email,
                    label: "Email ID",
                    value: userEmail,
                    onEdit: () {},
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
