import 'dart:io';
import 'package:flutter/material.dart';
import 'package:payansh/constants/app_colors.dart';
import 'package:payansh/constants/style_constants.dart';
import 'package:payansh/services/auth_service.dart';
import 'package:payansh/widgets/profile_item_widget.dart';
import 'package:payansh/services/api_service.dart';
import 'package:file_picker/file_picker.dart';

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
    _profileFuture = ApiService.getUserProfile().then((response) {
      print("User Profile Response: $response");
      return response;
    });
  }

  /// Opens a dialog to edit name and phone.
  void _showEditDialog(String currentName, String currentPhone) {
    TextEditingController nameController =
        TextEditingController(text: currentName);
    TextEditingController phoneController =
        TextEditingController(text: currentPhone);

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Edit Profile"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: "Name"),
                ),
                TextField(
                  controller: phoneController,
                  decoration: const InputDecoration(labelText: "Phone Number"),
                  keyboardType: TextInputType.phone,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close dialog
                },
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () async {
                  String newName = nameController.text.trim();
                  String newPhone = phoneController.text.trim();

                  // Only run API if at least one field changed.
                  if (newName != currentName || newPhone != currentPhone) {
                    // Show loading indicator
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) =>
                          const Center(child: CircularProgressIndicator()),
                    );

                    var updateResponse = await ApiService.updateProfile(
                      name: newName,
                      phoneNumber: newPhone,
                    );
                    Navigator.pop(context); // Close loading indicator

                    if (updateResponse["message"]
                        .toString()
                        .toLowerCase()
                        .contains("success")) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(updateResponse["message"])));
                      // Refresh profile data.
                      setState(() {
                        _profileFuture = ApiService.getUserProfile();
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              updateResponse["message"] ?? "Update failed")));
                    }
                  }
                  Navigator.pop(context); // Close the edit dialog.
                },
                child: const Text("Save"),
              ),
            ],
          );
        });
  }

  /// Opens file picker to choose a new profile picture and uploads it.
  Future<void> _pickAndUploadImage() async {
    // Use file_picker to select an image.
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null && result.files.single.path != null) {
      File imageFile = File(result.files.single.path!);
      // Show a loading indicator while uploading.
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );
      var response = await ApiService.updateProfilePicture(imageFile);
      Navigator.pop(context); // Close the loading indicator.

      if (response["message"].toString().toLowerCase().contains("success")) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(response["message"])));
        // Refresh profile data.
        setState(() {
          _profileFuture = ApiService.getUserProfile();
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(response["message"] ?? "Upload failed")));
      }
    }
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
            final phoneVerified = (userData['phone_verified'] == 1);
            final emailVerified = (userData['email_verified'] == 1);
            final profilePicture =
                userData['profile_picture'] ?? 'assets/images/user.png';

            return SingleChildScrollView(
              child: Column(
                children: [
                  // Header with Gradient and Profile Picture.
                  Container(
                    height: 220,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.gradientStart,
                          AppColors.gradientEnd,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.topRight,
                      ),
                    ),
                    child: Stack(
                      children: [
                        // Logout Button.
                        Positioned(
                          top: 50,
                          right: 16,
                          child: InkWell(
                            onTap: () {
                              AuthService.logout(context);
                            },
                            child: const Row(
                              children: [
                                Icon(Icons.logout, color: Colors.white),
                                SizedBox(width: 4),
                                Text("Logout",
                                    style: StyleConstants.whiteTextBold),
                              ],
                            ),
                          ),
                        ),
                        // Centered Profile Info.
                        Align(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Stack(
                                children: [
                                  CircleAvatar(
                                    radius: 50,
                                    backgroundColor: Colors.white,
                                    backgroundImage:
                                        profilePicture.startsWith('http')
                                            ? NetworkImage(profilePicture)
                                            : AssetImage(profilePicture)
                                                as ImageProvider,
                                  ),
                                  // Edit icon for updating profile picture.
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: GestureDetector(
                                      onTap: _pickAndUploadImage,
                                      child: const CircleAvatar(
                                        radius: 16,
                                        backgroundColor: Colors.blue,
                                        child: Icon(Icons.edit,
                                            size: 16, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(userName,
                                  style: StyleConstants.profileNameText),
                              const SizedBox(height: 4),
                              Text(userPhone,
                                  style: StyleConstants.profilePhoneText),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Profile Details Section.
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Column(
                      children: [
                        // Name row.
                        ProfileItemWidget(
                          icon: Icons.person,
                          label: "Name",
                          value: userName,
                          onEdit: () {
                            _showEditDialog(userName, userPhone);
                          },
                        ),
                        const Divider(height: 1),
                        // Contact Number row.
                        ProfileItemWidget(
                          icon: Icons.phone,
                          label: "Contact Number",
                          valueWidget: Row(
                            children: [
                              Text("$userPhone "),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: phoneVerified
                                      ? AppColors.verifiedColor.withOpacity(0.1)
                                      : AppColors.unverifiedColor
                                          .withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      phoneVerified
                                          ? Icons.check_circle
                                          : Icons.info_outline,
                                      size: 14,
                                      color: phoneVerified
                                          ? AppColors.verifiedColor
                                          : AppColors.unverifiedColor,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      phoneVerified ? "Verified" : "Unverified",
                                      style: StyleConstants.badgeText.copyWith(
                                        color: phoneVerified
                                            ? AppColors.verifiedColor
                                            : AppColors.unverifiedColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          onEdit: () {
                            _showEditDialog(userName, userPhone);
                          },
                        ),
                        const Divider(height: 1),
                        // Email row (editing not enabled for email).
                        ProfileItemWidget(
                          icon: Icons.email,
                          label: "Email ID",
                          valueWidget: Row(
                            children: [
                              Text("$userEmail "),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: emailVerified
                                      ? AppColors.verifiedColor.withOpacity(0.1)
                                      : AppColors.unverifiedColor
                                          .withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      emailVerified
                                          ? Icons.check_circle
                                          : Icons.info_outline,
                                      size: 14,
                                      color: emailVerified
                                          ? AppColors.verifiedColor
                                          : AppColors.unverifiedColor,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      emailVerified ? "Verified" : "Unverified",
                                      style: StyleConstants.badgeText.copyWith(
                                        color: emailVerified
                                            ? AppColors.verifiedColor
                                            : AppColors.unverifiedColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          onEdit: () {
                            // Optionally notify the user that email cannot be edited.
                          },
                        ),
                      ],
                    ),
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
