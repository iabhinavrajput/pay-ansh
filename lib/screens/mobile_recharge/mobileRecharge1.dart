import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payansh/widgets/gradient_button.dart';

import '../../constants/app_colors.dart';
import '../../constants/dimensions.dart';
import '../../theme/custom_themes/text_theme.dart';
import '../../widgets/app_bar_image.dart';
import 'selectOperator.dart';

class Mobilerecharge1 extends StatefulWidget {
  const Mobilerecharge1({super.key});

  @override
  State<Mobilerecharge1> createState() => _Mobilerecharge1State();
}

class _Mobilerecharge1State extends State<Mobilerecharge1> {
  final TextEditingController phoneController = TextEditingController();
  final RxBool isPhoneValid = false.obs;
  final RxBool showDropdownField = false.obs;
  String selectedOperator = '';

  @override
  void initState() {
    super.initState();
    phoneController.addListener(_validatePhone);
  }

  void _validatePhone() {
    final phone = phoneController.text.trim();
    // Check if it's exactly 10 digits and all numeric
    isPhoneValid.value = RegExp(r'^[0-9]{10}$').hasMatch(phone);
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  Future<void> _navigateToOperatorSelection() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SelectOperatorScreen(),
      ),
    );

    if (result != null) {
      setState(() {
        selectedOperator = result;
        showDropdownField.value = true; // Show the dropdown after selection
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarImage(
        title: 'Mobile Recharge',
        height: Dimensions.dynamicHeight(context, 0.15),
      ),
      body: Padding(
        padding: EdgeInsets.all(Dimensions.dynamicHeight(context, 0.025)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Mobile Number",
              style: TextStyle(
                color: AppColors.greytextColors,
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                letterSpacing: 0.25,
              ),
            ),
            const SizedBox(height: 5),
            Container(
              height: 45,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF5B86E5),
                    Color(0xFF36D1DC),
                  ],
                ),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              padding: const EdgeInsets.all(0.7),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(9)),
                ),
                child: TextField(
                  controller: phoneController,
                  cursorColor: const Color(0xFF5B86E5),
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  decoration: const InputDecoration(
                    isDense: true,
                    counterText: '',
                    hintText: '',
                    hintStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "+91",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    prefixIconConstraints: BoxConstraints(minWidth: 50),
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 7),
            Text(
              "Ensure this is a valid mobile number",
              style: TTextTheme.greymediumText,
            ),
            const SizedBox(height: 30),
            Obx(() {
              if (!showDropdownField.value) return const SizedBox.shrink();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Selected Operator",
                    style: TextStyle(
                      color: AppColors.greytextColors,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.25,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    height: 45,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: InkWell(
                      onTap: _navigateToOperatorSelection,
                      child:  
                      Container(
                        width: Dimensions.dynamicWidth(context, 1),
                        alignment: Alignment.centerLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                
                                selectedOperator.isEmpty
                                    ? "Select your operator"
                                    : selectedOperator,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                              Icon(Icons.arrow_drop_down)
                          ],
                        ),
                      ),
                    
                    ),
                  ),
                ],
              );
            }),
            const SizedBox(height: 50),
            Obx(() => GradientButton(
                  text: "Proceed",
                  onPressed: isPhoneValid.value
                      ? () {
                          debugPrint("Proceed with ${phoneController.text}");
                          showDropdownField.value = true; // Show the dropdown
                        }
                      : null,
                  isEnabled: isPhoneValid.value,
                )),
          ],
        ),
      ),
    );
  }
}
