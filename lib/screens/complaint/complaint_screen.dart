import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:payansh/constants/dimensions.dart';
import 'package:payansh/widgets/app_bar.dart';
import 'package:payansh/widgets/settings_option_tile.dart';
import 'package:payansh/widgets/title_appbar.dart';

class ComplaintScreen extends StatefulWidget {
  const ComplaintScreen({super.key});

  @override
  State<ComplaintScreen> createState() => _ComplaintScreenState();
}

class _ComplaintScreenState extends State<ComplaintScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleAppBar(
          height: Dimensions.dynamicHeight(context, 0.15),
          title: "Have a Complaint?"),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: 20),
            SettingsOptionTile(
              icon: HugeIcons.strokeRoundedTaskAdd01,
              title: "Complaint Registration",
              subtitle: "Register your complaint",
            ),
            SettingsOptionTile(
              icon:HugeIcons.strokeRoundedRoute01,
              title: "Track Complaint",
              subtitle: "Track your complaint here",
            ),
          ])),
    );
  }
}
