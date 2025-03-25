import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payansh/constants/app_colors.dart';
import 'package:payansh/constants/dimensions.dart';
import 'package:payansh/routes/routes.dart';
import 'package:payansh/screens/complaint/track/track_complaint.dart';
import 'package:payansh/screens/info.dart';
import 'package:payansh/screens/notification_settings.dart';

class SettingsOptionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String? content;

  const SettingsOptionTile({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (title == "Notifications Settings") {
          Get.to(() => const NotificationSettings());
        } else if (title == "Complaint Registration") {
          Get.toNamed(AppRoutes.complaint);
        } else if (title == "Track Complaint") {
          Get.to(() => const TrackComplaint());
        } else {
          Get.to(() => Info(title: title, content: content!));
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
                    color: Colors.black45,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
