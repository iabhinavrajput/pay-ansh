import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:payansh/constants/app_colors.dart';
import 'package:payansh/constants/dimensions.dart';
import 'package:payansh/controllers/complain_controller.dart';
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

  final ComplaintController complaintController = Get.put(ComplaintController());

  @override
  void initState() {
    super.initState();
    _transactionController.addListener(() {
      setState(() {
        isFilled = _transactionController.text.isNotEmpty;
        debugPrint("Transaction Controller Value: ${_transactionController.text}");
      });
    });

    _descriptionController.addListener(() {
      setState(() {
        isFilledDescription = _descriptionController.text.isNotEmpty;
        debugPrint("Description Controller Value: ${_descriptionController.text}");
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
      debugPrint("Form Validation: isFilled: $isFilled, isFilledDescription: $isFilledDescription, isComplaintTypeSelected: $isComplaintTypeSelected, isComplaintReasonSelected: $isComplaintReasonSelected, isFormValid: $isFormValid");
    });
  }

void onSelectComplaintType(String value) {
  setState(() {
    // Find the selected complaint type by matching the value
    var selectedType = complaintController.complaintTypes.firstWhere(
        (type) => type['type'] == value,
        orElse: () => {});  // Provide default value if not found
    selectedComplaintType = selectedType['id'].toString();
    isComplaintTypeSelected = true;
    debugPrint("Selected Complaint Type ID: $selectedComplaintType");
    validateForm();
  });
}

void onSelectComplaintReason(String value) {
  setState(() {
    // Find the selected complaint reason by matching the value
    var selectedReason = complaintController.complaintReasons.firstWhere(
        (reason) => reason['reason'] == value,
        orElse: () => {});  // Provide default value if not found
    selectedComplaintReason = selectedReason['id'].toString();
    isComplaintReasonSelected = true;
    debugPrint("Selected Complaint Reason ID: $selectedComplaintReason");
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
        body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.all(Dimensions.dynamicWidth(context, 0.05)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Dimensions.dynamicHeight(context, 0.01)),
                  Text("Complaint Type", style: TTextTheme.lightTextTheme.bodyLarge),
                  SizedBox(height: Dimensions.dynamicHeight(context, 0.001)),
                  Column(
                    children: [
                      Obx(() {
                        if (complaintController.isLoading.value) {
                          debugPrint("Complaint Types are loading...");
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
                                Text("Fetching data...", style: TTextTheme.greymediumText),
                              ],
                            ),
                          );
                        }

                        if (complaintController.complaintTypes.isEmpty) {
                          debugPrint("No complaint types available");
                          return Container(
                            height: 50,
                            alignment: Alignment.center,
                            child: Text("No complaint types available", style: TextStyle(color: Colors.red)),
                          );
                        }

                        // Extracting complaint types as a List<String>
                        List<String> complaintTypes = complaintController.complaintTypes
                            .map((type) => type['type'].toString()) // Corrected 'name' to 'type'
                            .toList();

                        return CustomDropdown(
                          title: "Select Complaint Type",
                          options: complaintTypes,
                          onSelect: onSelectComplaintType,
                        );
                      }),
                    ],
                  ),
                  SizedBox(height: Dimensions.dynamicHeight(context, 0.02)),
                  Text("Transaction Reference ID", style: TTextTheme.lightTextTheme.bodyLarge),
                  SizedBox(height: Dimensions.dynamicHeight(context, 0.001)),
                  Container(
                    height: Dimensions.dynamicHeight(context, 0.06),
                    decoration: BoxDecoration(
                      gradient: isFilled
                          ? LinearGradient(colors: [AppColors.gradientStart, AppColors.gradientEnd])
                          : LinearGradient(colors: [Colors.transparent, Colors.transparent]),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.all(1),
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
                  SizedBox(height: Dimensions.dynamicHeight(context, 0.02)),
                  Text("Description", style: TTextTheme.lightTextTheme.bodyLarge),
                  SizedBox(height: Dimensions.dynamicHeight(context, 0.001)),
                  Container(
                    height: Dimensions.dynamicHeight(context, 0.1),
                    padding: EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      gradient: isFilledDescription
                          ? LinearGradient(colors: [AppColors.gradientStart, AppColors.gradientEnd])
                          : LinearGradient(colors: [Colors.transparent, Colors.transparent]),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: isFilledDescription ? Colors.white : Color(0x33D9D9DA),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: TextFormField(
                        controller: _descriptionController,
                        expands: true,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          hintText: "Write Description",
                          hintStyle: TTextTheme.greymediumText,
                          border: InputBorder.none,
                          counterText: "",
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: Dimensions.dynamicHeight(context, 0.02)),
                  Text("Complaint Reason", style: TTextTheme.lightTextTheme.bodyLarge),
                  SizedBox(height: Dimensions.dynamicHeight(context, 0.001)),
                  Column(
                    children: [
                      Obx(() {
                        if (complaintController.isLoading.value) {
                          debugPrint("Complaint Reasons are loading...");
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
                                Text("Fetching data...", style: TTextTheme.greymediumText),
                              ],
                            ),
                          );
                        }

                        if (complaintController.complaintReasons.isEmpty) {
                          debugPrint("No complaint reasons available");
                          return Container(
                            height: 50,
                            alignment: Alignment.center,
                            child: Text("No complaint reasons available", style: TextStyle(color: Colors.red)),
                          );
                        }

                        // Extracting complaint reasons as a List<String>
                        List<String> complaintReasons = complaintController.complaintReasons
                            .map((reason) => reason['reason'].toString()) // Corrected 'name' to 'reason'
                            .toList();

                        return CustomDropdown(
                          title: "Select Complaint Reason",
                          options: complaintReasons,
                          onSelect: onSelectComplaintReason,
                        );
                      }),
                    ],
                  ),
                  SizedBox(height: Dimensions.dynamicHeight(context, 0.05)),
                    GradientButton(
                      text: "Submit",
                      onPressed: isFormValid
                        ? () {
                          // Ensure both complaint type and reason are non-null
                          if (selectedComplaintType != null && selectedComplaintReason != null) {
                            debugPrint("Submitting complaint with type: $selectedComplaintType, reason: $selectedComplaintReason");
                            complaintController.submitComplaint(
                              typeId: selectedComplaintType!,  // Use the non-null value with `!` operator
                              reasonId: selectedComplaintReason!,
                              subject: _transactionController.text,
                              description: _descriptionController.text,
                            );
                          } else {
                            debugPrint("Complaint type or reason is null");
                          }
                        }
                  : null,
              isEnabled: isFormValid,
            )


                ],
              ),
            ),
          ),
        ));
  }
}
