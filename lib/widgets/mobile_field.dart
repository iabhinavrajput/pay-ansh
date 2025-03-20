import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:payansh/constants/app_colors.dart';

class MobileNumberField extends StatefulWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;

  const MobileNumberField({
    super.key,
    required this.controller,
    this.onChanged,
  });

  @override
  State<MobileNumberField> createState() => _MobileNumberFieldState();
}

class _MobileNumberFieldState extends State<MobileNumberField> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus || widget.controller.text.isNotEmpty;
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
    return TextField(
      controller: widget.controller,
      focusNode: _focusNode,
      keyboardType: TextInputType.phone,
      maxLength: 10,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(10),
      ],
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        counterText: "",
        labelText: "Mobile Number*",
        labelStyle: TextStyle(
          color: _isFocused ? Colors.blue : Colors.grey.shade600,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            "+91",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade500,
            ),
          ),
        ),
        prefixIconConstraints: const BoxConstraints(minWidth: 50),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Icon(Icons.phone_outlined, color: Colors.blue),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.blue.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.blue.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.blue, width: 2),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      ),
    );
  }
}
