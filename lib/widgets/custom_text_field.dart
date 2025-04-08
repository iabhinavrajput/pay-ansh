import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/app_colors.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final bool obscureText;
  final TextInputType keyboardType;
  final String? Function(String)? validator; // Optional validator
  final bool showValidation;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.icon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.showValidation = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final FocusNode _focusNode = FocusNode();
  final RxString validationMessage = ''.obs;
  bool _isFocused = false;

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

    // Initial validation if needed
    if (widget.showValidation && widget.validator != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _validate(widget.controller.text);
      });
    }
  }

  void _validate(String value) {
    if (widget.validator != null) {
      final result = widget.validator!(value);
      validationMessage.value = result ?? '';
    }
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
        Stack(
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
                child: TextField(
                  controller: widget.controller,
                  focusNode: _focusNode,
                  obscureText: widget.obscureText,
                  keyboardType: widget.keyboardType,
                  onChanged: widget.showValidation ? _validate : null,
                  cursorColor: AppColors.gradientStart,
                  decoration: InputDecoration(
                    hintText: _showFloatingLabel ? '' : widget.hintText,
                    hintStyle: const TextStyle(color: AppColors.textColors),
                    suffixIcon: _showFloatingLabel
                        ? ShaderMask(
                            shaderCallback: (bounds) => const LinearGradient(
                              colors: [
                                AppColors.gradientStart,
                                AppColors.gradientEnd,
                              ],
                            ).createShader(Rect.fromLTWH(
                                0, 0, bounds.width, bounds.height)),
                            child: Icon(widget.icon, color: Colors.white),
                          )
                        : Icon(widget.icon, color: AppColors.textColors),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 15,
                    ),
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
        if (widget.showValidation)
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
