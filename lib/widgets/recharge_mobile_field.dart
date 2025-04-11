import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:payansh/constants/app_colors.dart';
import 'package:payansh/theme/custom_themes/text_theme.dart';

class MobileNumberFieldWidget extends StatefulWidget {
  final String label;
  final TextEditingController? controller;

  const MobileNumberFieldWidget({
    super.key,
    this.label = "Mobile Number",
    this.controller,
  });

  @override
  State<MobileNumberFieldWidget> createState() =>
      _MobileNumberFieldWidgetState();
}

class _MobileNumberFieldWidgetState extends State<MobileNumberFieldWidget> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller =
        widget.controller ?? TextEditingController();

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
          padding: const EdgeInsets.all(1),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: _isFocused
                ? const LinearGradient(
                    colors: [
                      AppColors.gradientEnd,
                      AppColors.gradientStart,
                    ],
                  )
                : null,
            border: _isFocused
                ? null
                : Border.all(color: Colors.grey.shade400, width: 0.5),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(9),
            ),
            child: Row(
              children: [
                if (_isFocused)
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "+91",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                Expanded(
                  child: TextField(
                    focusNode: _focusNode,
                    controller: controller,
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10),
                    ],
                    cursorColor: AppColors.gradientStart,
                    decoration: InputDecoration(
                      hintText: _isFocused
                          ? null
                          : "   Enter mobile number", // You can adjust hint as well if needed
                      hintStyle: const TextStyle(
                        color: AppColors.textColors,
                        fontSize: 14,
                      ),
                      counterText: "",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 18,
                        horizontal:
                            _isFocused ? 10 : 0, // Adjust spacing if no prefix
                      ),
                    ),
                  ),
                ),
              ],
            ),
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
