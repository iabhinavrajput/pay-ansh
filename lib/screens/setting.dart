import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payansh/screens/info.dart';

import '../widgets/title_appbar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TitleAppBar(height: 60, title: "App Setting & Info"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          _buildSettingsOption(
            icon: Icons.notifications,
            title: "Notifications Settings",
            subtitle: "Manage your notifications",
            content: """Here you can enable or disable notifications for the app. 
You can also set preferences for different types of notifications, such as push notifications, email alerts, and SMS updates.""",
          ),
          _buildSettingsOption(
            icon: Icons.privacy_tip,
            title: "Privacy Policy",
            subtitle: "View privacy policy",
            content: """We value your privacy. Our privacy policy outlines how we collect, use, and store your personal data. 
We do not share your data with third parties without your consent. Read the full privacy policy for more details.""",
          ),
          _buildSettingsOption(
            icon: Icons.description,
            title: "Terms & Conditions",
            subtitle: "View Terms & Conditions",
            content: """By using this app, you agree to our terms and conditions. These include guidelines on user behavior, 
account security, prohibited activities, and limitations of liability. Please read carefully before using the app.""",
          ),
          _buildSettingsOption(
            icon: Icons.article,
            title: "Content Policy",
            subtitle: "View Content Policy",
            content: """Our content policy ensures a safe and respectful community for all users. 
It covers acceptable content, prohibited activities, and moderation guidelines. 
Violations may result in account suspension.""",
          ),
          const Spacer(),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "App Version (3.2)",
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required String content,
  }) {
    return InkWell(
      onTap: () {
        Get.to(() => Info(title: title, content: content));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: Colors.blue),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
