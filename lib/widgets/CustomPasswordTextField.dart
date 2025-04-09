import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import '../constants/app_colors.dart';

class CustomPasswordTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final RxBool isPasswordVisible;
  final Function() togglePasswordVisibility;
  final bool showValidations;
  final Function(bool) onValidationChanged;

  const CustomPasswordTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.isPasswordVisible,
    required this.togglePasswordVisibility,
    this.showValidations = false,
    required this.onValidationChanged,
  });

  @override
  State<CustomPasswordTextField> createState() =>
      _CustomPasswordTextFieldState();
}

class _CustomPasswordTextFieldState extends State<CustomPasswordTextField> {
  final RxString validationMessage = ''.obs;
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  void validatePassword(String password) {
    if (password.isEmpty) {
      validationMessage.value = "Password cannot be empty";
      widget.onValidationChanged(false);
    } else if (password.length < 8) {
      validationMessage.value = "Password must be at least 8 characters";
      widget.onValidationChanged(false);
    } else if (!RegExp(r'[A-Z]').hasMatch(password)) {
      validationMessage.value =
          "Password must contain at least one uppercase letter";
      widget.onValidationChanged(false);
    } else if (!RegExp(r'[0-9]').hasMatch(password)) {
      validationMessage.value = "Password must contain at least one digit";
      widget.onValidationChanged(false);
    } else if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) {
      validationMessage.value =
          "Password must contain at least one special character";
      widget.onValidationChanged(false);
    } else {
      validationMessage.value = '';
      widget.onValidationChanged(true);
    }
    setState(() {}); // update label state
  }

  bool get _showFloatingLabel =>
      _isFocused || widget.controller.text.isNotEmpty;

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
    final borderRadius = BorderRadius.circular(10);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 0.0),
          child: Stack(
            clipBehavior: Clip.none,
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
                  color: Colors.white,
                  borderRadius: borderRadius,
                ),
                padding: _showFloatingLabel
                    ? const EdgeInsets.all(0.7)
                    : EdgeInsets.zero,
                child: Container(
                  decoration: BoxDecoration(
                    color: _showFloatingLabel
                        ? Colors.white
                        : AppColors.iconBackground,
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Obx(() => TextField(
                        controller: widget.controller,
                        focusNode: _focusNode,
                        obscureText: !widget.isPasswordVisible.value,
                        obscuringCharacter: '*',
                        onChanged: validatePassword,
                        cursorColor: AppColors.gradientStart,
                        decoration: InputDecoration(
                          hintText: _showFloatingLabel ? '' : widget.hintText,
                          hintStyle:
                              const TextStyle(color: AppColors.textColors),
                          suffixIcon: _showFloatingLabel
                              ? ShaderMask(
                                  shaderCallback: (bounds) =>
                                      const LinearGradient(
                                    colors: [
                                      AppColors.gradientStart,
                                      AppColors.gradientEnd,
                                    ],
                                  ).createShader(Rect.fromLTWH(
                                          0, 0, bounds.width, bounds.height)),
                                  child: IconButton(
                                    icon: Icon(
                                      widget.isPasswordVisible.value
                                          ? Icons.lock_open
                                          : HugeIcons.strokeRoundedLockPassword,
                                      color: Colors.white,
                                    ),
                                    onPressed: widget.togglePasswordVisibility,
                                  ),
                                )
                              : IconButton(
                                  icon: Icon(
                                    widget.isPasswordVisible.value
                                        ? Icons.lock_open
                                        : HugeIcons.strokeRoundedLockPassword,
                                    color: AppColors.textColors,
                                  ),
                                  onPressed: widget.togglePasswordVisibility,
                                ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                        ),
                      )),
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
                          AppColors.gradientEnd,
                        ],
                      ).createShader(
                          Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
                      child: Text(
                        widget.hintText,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        if (widget.showValidations)
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
