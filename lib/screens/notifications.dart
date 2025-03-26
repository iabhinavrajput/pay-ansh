import 'package:flutter/material.dart';
import 'package:payansh/constants/dimensions.dart';
import 'package:payansh/theme/custom_themes/text_theme.dart';
import 'package:payansh/widgets/notification_widget.dart';
import 'package:payansh/widgets/title_appbar.dart';

class Notifications extends StatelessWidget {
  const Notifications({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: TitleAppBar(
          height: Dimensions.dynamicHeight(context, 0.15),
          title: "Notifications"),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              "19 March, 2025",
              style: TTextTheme.greysmall,
            ),
            SizedBox(
              height: 20,
            ),
            NotificationWidget(
                text: "Complete Your KYC",
                description:
                    "Complete your KYC to use all benefits and services of PAYANCE. ",
                imagePath: 'assets/notification/noti1.png'),
          SizedBox(
              height: Dimensions.dynamicHeight(context, 0.015),
            ),  NotificationWidget(
                text: "Pick up from where you left!",
                description:
                    "Get ₹11 cashback, complete your electricity bill on PAYANCE | Avoid let fee.",
                imagePath: 'assets/notification/noti2.png'),
            SizedBox(
              height: Dimensions.dynamicHeight(context, 0.015),
            ),NotificationWidget(
                text: "₹0 Platform Fee on Mobile Recahrge",
                description:
                    "No Platform fee for mobile recharges, get your deal lock.",
                imagePath: 'assets/notification/noti3.png')
          ],
        ),
      ),
    );
  }
}
