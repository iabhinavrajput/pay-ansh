import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:payansh/constants/dimensions.dart';
import 'package:payansh/widgets/settings_option_tile.dart';
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
            SettingsOptionTile(
              icon: Icons.notifications,
              title: "Notifications Settings",
              subtitle: "Manage your notifications",
              content:
                  """Here you can enable or disable notifications for the app. 
        You can also set preferences for different types of notifications, such as push notifications, email alerts, and SMS updates.""",
            ),
            SettingsOptionTile(
              icon: Icons.privacy_tip,
              title: "Privacy Policy",
              subtitle: "View privacy policy",
              content:
                  """Lorem ipsum dolor sit amet consectetur. Tincidunt vel congue in urna. 
                  
Lorem ipsum dolor sit amet consectetur. Tincidunt vel congue in urna.

In pellentesque nunc semper vel sapien facilisi commodo. Felis dui ut at pretium mi quisque. Volutpat elementum scelerisque in volutpat nec cras integer.In pellentesque nunc semper vel sapien facilisi commodo. Felis dui ut at pretium mi quisque. Volutpat elementum scelerisque in volutpat nec cras integer. """,
            ),
            SettingsOptionTile(
              icon: Icons.description,
              title: "Terms & Conditions",
              subtitle: "View Terms & Conditions",
              content:
                  """Lorem ipsum dolor sit amet consectetur. Tincidunt vel congue in urna. 
                  
Lorem ipsum dolor sit amet consectetur. Tincidunt vel congue in urna.

In pellentesque nunc semper vel sapien facilisi commodo. Felis dui ut at pretium mi quisque. Volutpat elementum scelerisque in volutpat nec cras integer.In pellentesque nunc semper vel sapien facilisi commodo. Felis dui ut at pretium mi quisque. Volutpat elementum scelerisque in volutpat nec cras integer. """,
            ),
            SettingsOptionTile(
              icon: Icons.article,
              title: "Content Policy",
              subtitle: "View Content Policy",
              content:
                  """Lorem ipsum dolor sit amet consectetur. Tincidunt vel congue in urna. 
                  
Lorem ipsum dolor sit amet consectetur. Tincidunt vel congue in urna.

In pellentesque nunc semper vel sapien facilisi commodo. Felis dui ut at pretium mi quisque. Volutpat elementum scelerisque in volutpat nec cras integer.In pellentesque nunc semper vel sapien facilisi commodo. Felis dui ut at pretium mi quisque. Volutpat elementum scelerisque in volutpat nec cras integer. """,
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
}
