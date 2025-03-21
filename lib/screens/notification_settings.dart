import 'package:flutter/material.dart';
import 'package:payansh/theme/custom_themes/text_theme.dart';
import 'package:payansh/widgets/notification_widget.dart';
import 'package:payansh/widgets/title_appbar.dart';

class NotificationSettings extends StatelessWidget {
  const NotificationSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: TitleAppBar(height: 60, title: "Notifications"),
      
    );
  }
}
