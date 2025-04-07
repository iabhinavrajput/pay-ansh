import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payansh/constants/dimensions.dart';
import '../constants/app_colors.dart';

class CustomEmailTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final Function(bool) onValidationChanged;

  const CustomEmailTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.icon,
    required this.onValidationChanged,
  });

  @override
  State<CustomEmailTextField> createState() => _CustomEmailTextFieldState();
}

class _CustomEmailTextFieldState extends State<CustomEmailTextField> {
  final RxString validationMessage = ''.obs;
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  void validateEmail(String email) {
    if (email.isEmpty) {
      validationMessage.value = "Email cannot be empty";
      widget.onValidationChanged(false);
    } else if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(email)) {
      validationMessage.value = "Enter a valid email address";
      widget.onValidationChanged(false);
    } else {
      validationMessage.value = '';
      widget.onValidationChanged(true);
    }
    setState(() {}); // To update floating label
  }

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

  bool get _showFloatingLabel =>
      _isFocused || widget.controller.text.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(10);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Stack(
            clipBehavior: Clip.none, // 👈 Allow label to overflow upwards

            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: _showFloatingLabel
                      ? const LinearGradient(
                          colors: [
                            AppColors.gradientStart,
                            AppColors.gradientEnd,
                          ],
                        )
                      : null,
                  color:Colors.white,
                  borderRadius: borderRadius,
                ),
                padding: _showFloatingLabel
                    ? const EdgeInsets.all(0.7)
                    : EdgeInsets.zero,
                child: Container(
                  decoration: BoxDecoration(
                    color: _showFloatingLabel
                        ? Colors.white
                        : AppColors
                            .iconBackground, // match outer background when inactive
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: TextField(
                    controller: widget.controller,
                    focusNode: _focusNode,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: validateEmail,
                    cursorColor: AppColors.gradientStart,
                    decoration: InputDecoration(
                      hintText: _showFloatingLabel ? '' : widget.hintText,
                      hintStyle: const TextStyle(
                        color: AppColors.textColors,
                      ),
                      suffixIcon: _showFloatingLabel
                          ? ShaderMask(
                              shaderCallback: (bounds) => const LinearGradient(
                                colors: [
                                  AppColors.gradientStart,
                                  AppColors.gradientEnd
                                ],
                              ).createShader(Rect.fromLTWH(
                                  0, 0, bounds.width, bounds.height)),
                              child: Icon(widget.icon, color: Colors.white),
                            )
                          : Icon(widget.icon, color: AppColors.textColors),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                    ),
                  ),
                ),
              ),
              if (_showFloatingLabel)
                Positioned(
                  left: 15,
                  top: -7,
                  child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: ShaderMask(
                        shaderCallback: (bounds) => const LinearGradient(
                          colors: [
                            AppColors.gradientStart,
                            AppColors.gradientEnd
                          ],
                        ).createShader(
                            Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
                        child: Text(
                          widget.hintText,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors
                                .white, // 👈 important for ShaderMask to apply color
                          ),
                        ),
                      )),
                ),
            ],
          ),
        ),
        Obx(() => validationMessage.value.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  validationMessage.value,
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              )
            : const SizedBox.shrink()),
      ],
    );
  }
}
