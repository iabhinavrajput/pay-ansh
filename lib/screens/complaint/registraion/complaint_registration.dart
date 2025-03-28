import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:payansh/constants/app_colors.dart';
import 'package:payansh/constants/dimensions.dart';
import 'package:payansh/controllers/complain_controller.dart';
import 'package:payansh/screens/complaint/complaint_screen.dart';
import 'package:payansh/theme/custom_themes/text_theme.dart';
import 'package:payansh/widgets/bottom_sheet.dart';
import 'package:payansh/widgets/custom_dropdown.dart';
import 'package:payansh/widgets/gradient_button.dart';
import 'package:payansh/widgets/title_appbar.dart';

class ComplaintRegistration extends StatefulWidget {
  const ComplaintRegistration({super.key});

  @override
  State<ComplaintRegistration> createState() => _ComplaintRegistrationState();
}

class _ComplaintRegistrationState extends State<ComplaintRegistration> {
  bool isFilled = false;
  bool isFilledDescription = false;
  bool isFormValid = false;

  final TextEditingController _transactionController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  bool isComplaintTypeSelected = false;
  bool isComplaintReasonSelected = false;

  String? selectedComplaintType;
  String? selectedComplaintReason;

  final TextEditingController _controller = TextEditingController();
  final int maxWords = 50; // Set max words dynamically if needed
  final ComplaintController complaintController =
      Get.put(ComplaintController());

  @override
  void initState() {
    super.initState();
    _transactionController.addListener(() {
      setState(() {
        isFilled = _transactionController.text.isNotEmpty;
      });
    });

    _descriptionController.addListener(() {
      setState(() {
        isFilledDescription = _descriptionController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _transactionController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void validateForm() {
    setState(() {
      isFilled = _transactionController.text.isNotEmpty;
      isFilledDescription = _descriptionController.text.isNotEmpty;
      isFormValid = isFilled &&
          isFilledDescription &&
          isComplaintTypeSelected &&
          isComplaintReasonSelected;
    });
  }

  void onSelectComplaintType(String value) {
    setState(() {
      selectedComplaintType = value;
      isComplaintTypeSelected = true;
      validateForm();
    });
  }

  void onSelectComplaintReason(String value) {
    setState(() {
      selectedComplaintReason = value;
      isComplaintReasonSelected = true;
      validateForm();
    });
  }

  void _onTextChanged(String value) {
    List<String> words = value.trim().split(RegExp(r'\s+'));
    if (words.length > maxWords) {
      // Limit text if word count exceeds maxWords
      String newText = words.sublist(0, maxWords).join(" ");
      _controller.value = TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length),
      );
    }
    setState(() {}); // Refresh UI if needed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: TitleAppBar(
          height: Dimensions.dynamicHeight(context, 0.15),
          title: "Complaint Registration",
        ),
        body:SafeArea(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(), // Smooth scrolling effect
        child: Padding(
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
              Column(
                children: [
                  Obx(() {
                    if (complaintController.isLoading.value) {
                      return Container(
                        height: 50,
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: Color(0x33D9D9DA),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Fetching data...",
                                style: TTextTheme.greymediumText),
                            // SizedBox(
                            //   width: 20,
                            //   height: 20,
                            //   child: CircularProgressIndicator(strokeWidth: 2),
                            // ),
                          ],
                        ),
                      );
                    }

                    if (complaintController.complaintTypes.isEmpty) {
                      return Container(
                        height: 50,
                        alignment: Alignment.center,
                        child: Text("No complaint types available",
                            style: TextStyle(color: Colors.red)),
                      );
                    }

                    return CustomDropdown(
                      title: "Select Complaint Type",
                      options: complaintController.complaintTypes,
                      onSelect: onSelectComplaintType,
                    );
                  }),
                ],
              ),
              SizedBox(
                height: Dimensions.dynamicHeight(context, 0.02),
              ),
              Text(
                "Transaction Reference ID",
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
                      hintText: "Enter Transaction Reference ID",
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
              Text(
                "Description",
                style: TTextTheme.lightTextTheme.bodyLarge,
              ),
              SizedBox(
                height: Dimensions.dynamicHeight(context, 0.001),
              ),
              Container(
                height: Dimensions.dynamicHeight(context, 0.1),
                padding: EdgeInsets.all(1), // Border padding effect
                decoration: BoxDecoration(
                  gradient: isFilledDescription
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
                child: Container(
                  decoration: BoxDecoration(
                    color:
                        isFilledDescription ? Colors.white : Color(0x33D9D9DA),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: TextFormField(
                    controller: _descriptionController,
                    expands: true, // Allows text to fill the container
                    maxLines: null, // Makes it multiline
                    keyboardType: TextInputType.multiline,
                    onChanged: _onTextChanged, // Calls function to limit words
                    decoration: InputDecoration(
                      hintText: "Write Description",
                      hintStyle: TTextTheme.greymediumText,
                      border: InputBorder.none, // Removes the default border
                      counterText: "", // Hides the default counter
                    ),
                    // inputFormatters: [
                    //   FilteringTextInputFormatter.allow(
                    //       RegExp(r'^[a-zA-Z]*$')), // Allows only alphabets
                    //   // Limits input to 10 characters
                    // ],
                  ),
                ),
              ),
              SizedBox(
                height: Dimensions.dynamicHeight(context, 0.02),
              ),
              Text(
                "Complaint Reason",
                style: TTextTheme.lightTextTheme.bodyLarge,
              ),
              SizedBox(
                height: Dimensions.dynamicHeight(context, 0.001),
              ),
              Column(
                children: [
                  Obx(() {
                    if (complaintController.isLoading.value) {
                      return Container(
                        height: 50,
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: Color(0x33D9D9DA),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Fetching data...",
                                style:  TTextTheme.greymediumText),
                            // SizedBox(
                            //   width: 20,
                            //   height: 20,
                            //   child: CircularProgressIndicator(strokeWidth: 2),
                            // ),
                          ],
                        ),
                      );
                    }

                    if (complaintController.complaintReasons.isEmpty) {
                      return Container(
                        height: 50,
                        alignment: Alignment.center,
                        child: Text("No complaint reasons available",
                            style: TextStyle(color: Colors.red)),
                      );
                    }

                    return CustomDropdown(
                      title: "Select Complaint Reason",
                      options: complaintController.complaintReasons,
                      onSelect: onSelectComplaintReason,
                    );
                  }),
                ],
              ),
              SizedBox(
                height: Dimensions.dynamicHeight(context, 0.05),
              ),
              GradientButton(
                text: "Submit",
                onPressed: isFormValid
                    ? () {
                        ConfirmationBottomSheet.show(
                          context,
                          title: "Complaint Registered Successfully",
                          description:
                              "Your complaint has been registered successfully.",
                          message:
                              "Your complaint Id is CD12344 assign to Payansh. To track your registered complaint you can use the complaint Id",
                          action: () {
                            Get.to(
                                () => ComplaintScreen()); // Example navigation
                          },
                        );
                      }
                    : null,
                isEnabled: isFormValid,
              )
            ])))));
  }
}
