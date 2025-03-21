import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:payansh/constants/app_colors.dart';
import 'package:payansh/constants/dimensions.dart';
import 'package:payansh/screens/info.dart';
import 'package:payansh/screens/notification_settings.dart';

import '../widgets/title_appbar.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _appVersion = "Loading...";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
    return Scaffold(
      appBar: TitleAppBar(
          height: Dimensions.dynamicHeight(context, 0.15),
          title: "App Setting & Info"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            _buildSettingsOption(
              context: context,
              icon: Icons.notifications,
              title: "Notifications Settings",
              subtitle: "Manage your notifications",
              content:
                  """Here you can enable or disable notifications for the app. 
        You can also set preferences for different types of notifications, such as push notifications, email alerts, and SMS updates.""",
            ),
            _buildSettingsOption(
              context: context, // Pass context here

              icon: Icons.privacy_tip,
              title: "Privacy Policy",
              subtitle: "View privacy policy",
              content:
                  """Lorem ipsum dolor sit amet consectetur. Tincidunt vel congue in urna. """,
            ),
            _buildSettingsOption(
              context: context, // Pass context here

              icon: Icons.description,
              title: "Terms & Conditions",
              subtitle: "View Terms & Conditions",
              content:
                  """By using this app, you agree to our terms and conditions. These include guidelines on user behavior, 
        account security, prohibited activities, and limitations of liability. Please read carefully before using the app.""",
            ),
            _buildSettingsOption(
              context: context,
              icon: Icons.article,
              title: "Content Policy",
              subtitle: "View Content Policy",
              content:
                  """Our content policy ensures a safe and respectful community for all users. 
        It covers acceptable content, prohibited activities, and moderation guidelines. 
        Violations may result in account suspension.""",
            ),
            Padding(
              padding: EdgeInsets.only(top: 16.0),
              child: Text(
                "App Version ($_appVersion)",
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsOption({
    required BuildContext context, // Pass context as a parameter

    required IconData icon,
    required String title,
    required String subtitle,
    required String content,
  }) {
    String _appVersion = "Loading...";

    return InkWell(
      onTap: () {
        if (title == "Notifications Settings") {
          Get.to(() => const NotificationSettings());
        } else {
          Get.to(() => Info(title: title, content: content));
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Icon(
                icon,
                color: AppColors.drawerTextColor,
                size: Dimensions.dynamicWidth(context, 0.047),
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: Dimensions.dynamicWidth(context, 0.035),
                    fontWeight: FontWeight.normal,
                    color: AppColors.drawerTextColor,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                      fontSize: Dimensions.dynamicWidth(context, 0.03),
                      color: Colors.black45),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
