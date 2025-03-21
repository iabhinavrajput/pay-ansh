import 'package:flutter/material.dart';
import 'package:payansh/constants/dimensions.dart';
import 'package:payansh/theme/custom_themes/text_theme.dart';
import 'package:payansh/widgets/custom_dropdown.dart';
import 'package:payansh/widgets/title_appbar.dart';

class ComplaintRegistration extends StatefulWidget {
  const ComplaintRegistration({super.key});

  @override
  State<ComplaintRegistration> createState() => _ComplaintRegistrationState();
}

class _ComplaintRegistrationState extends State<ComplaintRegistration> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: TitleAppBar(
        height: Dimensions.dynamicHeight(context, 0.15),
        title: "Complaint Registration",
      ),
      body:Padding(
        padding: EdgeInsets.all(Dimensions.dynamicWidth(context, 0.05)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "Complaint Type",
            style: TTextTheme.lightTextTheme.bodyLarge,
          ),
          SizedBox(
            height: Dimensions.dynamicHeight(context, 0.01),
          ),
          CustomDropdown(
          title: "Select Complaint Type",
          options: ["Transaction Base", "Mobile Recharge", "Postpaid Bill Payments",'Gas Bill Payments','Loan Repayments','Other complaint type'],
        ),
        ]))
    );
  }
}
