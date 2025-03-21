import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:payansh/constants/app_colors.dart';
import 'package:payansh/constants/dimensions.dart';
import 'package:payansh/theme/custom_themes/text_theme.dart';
import 'package:payansh/widgets/title_appbar.dart';

class NotificationSettings extends StatefulWidget {
  const NotificationSettings({super.key});

  @override
  State<NotificationSettings> createState() => _NotificationSettingsState();
}

class _NotificationSettingsState extends State<NotificationSettings> {
  bool status = false; // Move status here to maintain state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: TitleAppBar(
        height: Dimensions.dynamicHeight(context, 0.15),
        title: "Notifications",
      ),
      body: Padding(
        padding: EdgeInsets.all(Dimensions.dynamicWidth(context, 0.05)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Notification Type",
              style: TTextTheme.lightTextTheme.bodyLarge,
            ),
            SizedBox(
              height: Dimensions.dynamicHeight(context, 0.01),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
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
                        Icons.percent,
                        color: AppColors.drawerTextColor,
                        size: Dimensions.dynamicWidth(context, 0.047),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Promotional",
                          style: TextStyle(
                            fontSize: Dimensions.dynamicWidth(context, 0.035),
                            fontWeight: FontWeight.normal,
                            color: AppColors.drawerTextColor,
                          ),
                        ),
                        Text(
                          "Offers & cashbacks",
                          style: TextStyle(
                              fontSize: Dimensions.dynamicWidth(context, 0.03),
                              color: Colors.black45),
                        ),
                      ],
                    ),
                  ],
                ),
                FlutterSwitch(
                  width: Dimensions.dynamicWidth(context, 0.14),
                  height: 35.0,
                  valueFontSize: 14.0,
                  toggleSize: 25.0,
                  value: status,
                  borderRadius: 20.0,
                  padding: 4.0,
                  showOnOff: true,
                  activeText: '',
                  inactiveText: '',
                  activeColor: Color(0xff47C546),
                  onToggle: (val) {
                    setState(() {
                      status = val;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
