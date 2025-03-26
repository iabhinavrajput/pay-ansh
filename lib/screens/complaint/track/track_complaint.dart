import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:payansh/constants/app_colors.dart';
import 'package:payansh/constants/dimensions.dart';
import 'package:payansh/screens/complaint/track/view_complaint.dart';
import 'package:payansh/theme/custom_themes/text_theme.dart';
import 'package:payansh/widgets/custom_dropdown.dart';
import 'package:payansh/widgets/gradient_button.dart';
import 'package:payansh/widgets/title_appbar.dart';

class TrackComplaint extends StatefulWidget {
  const TrackComplaint({super.key});

  @override
  State<TrackComplaint> createState() => _TrackComplaintState();
}

class _TrackComplaintState extends State<TrackComplaint> {
  bool isFilled = false;
  bool isFormValid = false;

  final TextEditingController _transactionController = TextEditingController();

  bool isComplaintTypeSelected = false;

  String? selectedComplaintType;

  @override
  void initState() {
    super.initState();
    _transactionController.addListener(() {
      setState(() {
        isFilled = _transactionController.text.isNotEmpty;
      });
      validateForm(); // Call validateForm() here
    });
  }

  @override
  void dispose() {
    _transactionController.dispose();
    super.dispose();
  }

  void validateForm() {
    setState(() {
      isFilled = _transactionController.text.isNotEmpty;
      isFormValid = isFilled && isComplaintTypeSelected;
    });
  }

  void onSelectComplaintType(String value) {
    setState(() {
      selectedComplaintType = value;
      isComplaintTypeSelected = true;
      validateForm();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: TitleAppBar(
          height: Dimensions.dynamicHeight(context, 0.15),
          title: "Complaint Registration",
        ),
        body: Padding(
            padding: EdgeInsets.all(Dimensions.dynamicWidth(context, 0.05)),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: Dimensions.dynamicHeight(context, 0.01),
              ),
              Text(
                "Complaint Type",
                style: TTextTheme.lightTextTheme.bodyLarge,
              ),
              SizedBox(
                height: Dimensions.dynamicHeight(context, 0.001),
              ),
              CustomDropdown(
                title: "Select Complaint Type",
                options: [
                  "Transaction Base",
                  "Mobile Recharge",
                  "Postpaid Bill Payments",
                  'Gas Bill Payments',
                  'Loan PayOff',
                  'Other complaint type'
                ],
                onSelect: onSelectComplaintType,
              ),
              SizedBox(
                height: Dimensions.dynamicHeight(context, 0.02),
              ),
              Text(
                "Complaint ID",
                style: TTextTheme.lightTextTheme.bodyLarge,
              ),
              SizedBox(
                height: Dimensions.dynamicHeight(context, 0.001),
              ),
              Container(
                height: Dimensions.dynamicHeight(context, 0.06),
                decoration: BoxDecoration(
                  gradient: isFilled
                      ? LinearGradient(
                          colors: [
                            AppColors.gradientStart,
                            AppColors.gradientEnd
                          ],
                        )
                      : LinearGradient(
                          colors: [Colors.transparent, Colors.transparent],
                        ),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.all(1), // Border padding effect
                child: Container(
                  decoration: BoxDecoration(
                    color: isFilled ? Colors.white : Color(0x33D9D9DA),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: TextFormField(
                    controller: _transactionController,
                    decoration: InputDecoration(
                      hintText: "Enter Complaint ID",
                      hintStyle: TTextTheme.greymediumText,
                      border: InputBorder.none,
                      counterText: "",
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z]*$')),
                      LengthLimitingTextInputFormatter(10),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: Dimensions.dynamicHeight(context, 0.02),
              ),
              GradientButton(
                text: "View",
                onPressed: isFormValid
                    ? () {
                        Get.to(ViewComplaint());
                      }
                    : null,
                isEnabled: isFormValid,
              )
            ])));
  }
}
