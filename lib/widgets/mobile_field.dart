import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:payansh/constants/app_colors.dart';

class MobileNumberField extends StatefulWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final String label;

  const MobileNumberField({
    super.key,
    required this.controller,
    this.onChanged,
    this.label = 'Mobile Number*',
  });

  @override
  State<MobileNumberField> createState() => _MobileNumberFieldState();
}

class _MobileNumberFieldState extends State<MobileNumberField> {
  final FocusNode _focusNode = FocusNode();
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
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(10);
    return Stack(
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
          padding:
              _showFloatingLabel ? const EdgeInsets.all(0.7) : EdgeInsets.zero,
          child: Container(
            decoration: BoxDecoration(
              color:
                  _showFloatingLabel ? Colors.white : AppColors.iconBackground,
              borderRadius: BorderRadius.circular(9),
            ),
            child: TextField(
              controller: widget.controller,
              focusNode: _focusNode,
              keyboardType: TextInputType.phone,
              maxLength: 10,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
              ],
              onChanged: widget.onChanged,
              cursorColor: AppColors.gradientStart,
              decoration: InputDecoration(
                counterText: '',
                hintText: _showFloatingLabel ? '' : widget.label,
                hintStyle: const TextStyle(
                  color: AppColors.textColors,
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "+91",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
                prefixIconConstraints: const BoxConstraints(minWidth: 50),
                suffixIcon: _showFloatingLabel
                    ? ShaderMask(
                        shaderCallback: (bounds) => const LinearGradient(
                          colors: [
                            AppColors.gradientStart,
                            AppColors.gradientEnd,
                          ],
                        ).createShader(
                            Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
                        child: const Icon(Icons.phone_outlined,
                            color: Colors.white),
                      )
                    : Icon(Icons.phone_outlined, color: AppColors.textColors),
                border: InputBorder.none,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
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
                  widget.label,
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
    );
  }
}
