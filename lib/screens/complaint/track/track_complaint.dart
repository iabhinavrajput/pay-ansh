import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:payansh/constants/app_colors.dart';
import 'package:payansh/constants/dimensions.dart';
import 'package:payansh/controllers/complain_controller.dart';
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
  final ComplaintController complaintController = Get.put(ComplaintController());

  bool isComplaintTypeSelected = false;
  String? selectedComplaintType;
  String? selectedComplaintTypeId; // To store the actual ID

  @override
  void initState() {
    super.initState();
    _transactionController.addListener(() {
      setState(() {
        isFilled = _transactionController.text.isNotEmpty;
      });
      validateForm();
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

      // Find the ID corresponding to the selected type
      selectedComplaintTypeId = complaintController.complaintTypes
          .firstWhere((type) => type['type'] == value, orElse: () => {})['id']
          ?.toString();

      validateForm();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: TitleAppBar(
        height: Dimensions.dynamicHeight(context, 0.15),
        title: "Complaint Tracking",
      ),
      body: Padding(
        padding: EdgeInsets.all(Dimensions.dynamicWidth(context, 0.05)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Complaint Type", style: TTextTheme.lightTextTheme.bodyLarge),
            SizedBox(height: Dimensions.dynamicHeight(context, 0.01)),

            Obx(() {
              if (complaintController.isLoading.value) {
                return Container(
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: const Color(0x33D9D9DA),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text("Fetching data...", style: TTextTheme.greymediumText),
                  ),
                );
              }

              if (complaintController.complaintTypes.isEmpty) {
                return Container(
                  height: 50,
                  alignment: Alignment.center,
                  child: const Text("No complaint types available", style: TextStyle(color: Colors.red)),
                );
              }

              List<String> complaintTypes = complaintController.complaintTypes
                  .map((type) => type['type'].toString())
                  .toList();

              return CustomDropdown(
                title: "Select Complaint Type",
                options: complaintTypes,
                onSelect: onSelectComplaintType,
              );
            }),

            SizedBox(height: Dimensions.dynamicHeight(context, 0.02)),

            Text("Complaint ID", style: TTextTheme.lightTextTheme.bodyLarge),
            SizedBox(height: Dimensions.dynamicHeight(context, 0.001)),

            Container(
              height: Dimensions.dynamicHeight(context, 0.06),
              decoration: BoxDecoration(
                gradient: isFilled
                    ? const LinearGradient(colors: [AppColors.gradientStart, AppColors.gradientEnd])
                    : const LinearGradient(colors: [Colors.transparent, Colors.transparent]),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(1), // Border padding effect
              child: Container(
                decoration: BoxDecoration(
                  color: isFilled ? Colors.white : const Color(0x33D9D9DA),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextFormField(
                  controller: _transactionController,
                  decoration: const InputDecoration(
                    hintText: "Enter Complaint ID",
                    hintStyle: TTextTheme.greymediumText,
                    border: InputBorder.none,
                    counterText: "",
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z0-9]*$')), // Alphanumeric allowed
                    LengthLimitingTextInputFormatter(10),
                  ],
                ),
              ),
            ),

            SizedBox(height: Dimensions.dynamicHeight(context, 0.02)),

            GradientButton(
              text: "View",
              onPressed: isFormValid
                  ? () {
                      Get.to(() => ViewComplaint(
                            typeId: selectedComplaintTypeId ?? '', // Provide a default empty string if null
                            complaintId: _transactionController.text,
                          ));
                    }
                  : null,
              isEnabled: isFormValid,
            )
          ],
        ),
      ),
    );
  }
}
