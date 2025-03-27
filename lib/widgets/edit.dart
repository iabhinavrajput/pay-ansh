import 'package:flutter/material.dart';
import 'package:payansh/constants/app_colors.dart';
import 'package:payansh/constants/dimensions.dart';
import 'package:payansh/widgets/gradient_button.dart';

class EditBottomSheet extends StatefulWidget {
  final String title;
  final String oldValue;
  final Function(String) onSubmit;
  final IconData? icon; // New: Accepts an optional icon

  const EditBottomSheet({
    super.key,
    required this.title,
    required this.oldValue,
    required this.onSubmit,
    this.icon, // New: Optional icon parameter
  });

  @override
  State<EditBottomSheet> createState() => _EditBottomSheetState();
}

class _EditBottomSheetState extends State<EditBottomSheet> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.oldValue; // Set old value in text field
  }

  @override
  Widget build(BuildContext context) {
    return 
    Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: Dimensions.dynamicWidth(context, 0.07),
        right: Dimensions.dynamicWidth(context, 0.07),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: Dimensions.dynamicHeight(context, 0.07)),
          
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              labelText: widget.title,
              labelStyle: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                foreground: Paint()
                  ..shader = const LinearGradient(
                    colors: [
                      AppColors.gradientStart,
                      AppColors.gradientEnd
                    ], // Gradient colors
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 30.0)),
              ),
              contentPadding: const EdgeInsets.only(
                left: 20,
              ),

              // Icon (if provided)
              suffixIcon: widget.icon != null
                  ? Padding(
                      padding:
                          const EdgeInsets.only(right: 10), // Add right padding
                      child: Icon(widget.icon, color: Color(0xffD9D9DA)),
                    )
                  : null,

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Color(0xffD9D9DA), // Border color
                  width: 0.8, // Force a thin border
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Color(0xffD9D9DA), // Same border color
                  width: 0.8, // Thin border width when not focused
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.blue, // Highlight color on focus
                  width: 1, // Slightly thicker on focus
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          // ElevatedButton(
          //   onPressed: () {
          //     widget.onSubmit(_controller.text); // Call action button function
          //     Navigator.pop(context);
          //   },
          //   child: const Text("Save"),
          // ),
          GradientButton(text: "Save", onPressed: () {}),
           SizedBox(height: Dimensions.dynamicHeight(context, 0.08)),
        ],
      ),
    );
  }
}
