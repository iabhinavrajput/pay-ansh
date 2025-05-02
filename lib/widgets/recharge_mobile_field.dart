import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:payansh/constants/app_colors.dart';
import 'package:payansh/constants/dimensions.dart';
import 'package:payansh/theme/custom_themes/text_theme.dart';

class MobileNumberFieldWidget extends StatefulWidget {
  final String label;

  const MobileNumberFieldWidget({
    super.key,
    this.label = "Mobile Number",
  });

  @override
  State<MobileNumberFieldWidget> createState() =>
      _MobileNumberFieldWidgetState();
}

class _MobileNumberFieldWidgetState extends State<MobileNumberFieldWidget> {


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final TextEditingController controller =
        // widget.controller ?? TextEditingController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            color: AppColors.greytextColors,
            fontSize: 14,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            letterSpacing: 0.25,
          ),
        ),
        const SizedBox(height: 5),
        Container(
          // height: 30,
          padding: const EdgeInsets.all(1),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade400, width: 0.5),
          ),
          child: Container(
            width: Dimensions.dynamicWidth(context, 1),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(9),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text("   Enter mobile number",style: TextStyle(
                          color: AppColors.textColors,
                          fontSize: 14,
                        ),),
            ),
            // child: Row(
            //   children: [
             
                // Expanded(
                  // child: TextField(
                  //   keyboardType: TextInputType.phone,
                  //   maxLength: 10,
                  //   inputFormatters: [
                  //     FilteringTextInputFormatter.digitsOnly,
                  //     LengthLimitingTextInputFormatter(10),
                  //   ],
                  //   cursorColor: AppColors.gradientStart,
                  //   decoration: InputDecoration(
                  //     hintText:"   Enter mobile number", // You can adjust hint as well if needed
                  //     hintStyle: const TextStyle(
                  //       color: AppColors.textColors,
                  //       fontSize: 14,
                  //     ),
                  //     counterText: "",
                  //     border: InputBorder.none,
                  //     contentPadding: EdgeInsets.symmetric(
                  //       vertical: 18,
                  //       horizontal:
                  //           0, // Adjust spacing if no prefix
                  //     ),
                  //   ),
                  // ),
                // ),
            //   ],
            // ),
          ),
        ),
        const SizedBox(height: 7),
        Text(
          "Ensure this is a valid mobile number",
          style: TTextTheme.greymediumText,
        )
      ],
    );
  }
}
