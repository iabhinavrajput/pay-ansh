import 'package:flutter/material.dart';
import 'package:payansh/constants/app_colors.dart';
import 'package:payansh/constants/dimensions.dart';
import 'package:payansh/theme/custom_themes/text_theme.dart';
import 'package:payansh/controllers/dropdown_controller.dart';

class CustomDropdown extends StatefulWidget {
  final String title;
  final List<String> options;
  final Function(String value) onSelect; // Callback function for selection

  const CustomDropdown({
    required this.title,
    required this.options,
    required this.onSelect,
    Key? key,
  }) : super(key: key);

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  late DropdownController controller;
  String? selectedValue; // Store the selected value

  @override
  void initState() {
    super.initState();
    controller = DropdownController();
    controller.setItems(widget.options);
  }

  String _truncateText(String text, int maxLength) {
    if (text.length > maxLength) {
      return '${text.substring(0, maxLength)}...';
    }
    return text;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showDropdownPopup(context);
      },
      child: Stack(
        children: [
          // Gradient Border
          Container(
            height: Dimensions.dynamicHeight(context, 0.06),
            decoration: BoxDecoration(
              gradient: selectedValue == null
                  ? LinearGradient(
                      colors: [
                        Colors.transparent,
                        Colors.transparent
                      ], // Gradient colors
                    )
                  : LinearGradient(
                      colors: [
                        AppColors.gradientStart,
                        AppColors.gradientEnd
                      ], // Gradient colors
                    ),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.all(1), // Padding for border effect
            child: Container(
              decoration: BoxDecoration(
                color: selectedValue == null ? Color(0x33D9D9DA) : Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    selectedValue == null
                        ? widget.title
                        : _truncateText(selectedValue!,
                            35), // Show selected option or title
                    style: selectedValue == null
                        ? TTextTheme.greymediumText
                        : TTextTheme.lightTextTheme.bodySmall,
                  ),
                  Icon(Icons.keyboard_arrow_down,
                      color: selectedValue == null
                          ? Color(0xffB8B8BC)
                          : Color(0xff22415F),
                      size: Dimensions.dynamicWidth(context, 0.07)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showDropdownPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          titlePadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          title: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              gradient: AppColors.userLetterBg,
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Select Complaint Type",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: Dimensions.dynamicWidth(context, 0.04),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.close, color: Colors.white, size: 20),
                  ),
                )
              ],
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: controller.items.map((item) {
                return ListTile(
                  title: Text(
                    item,
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                  trailing: Checkbox(
                    value: selectedValue == item,
                    onChanged: (isChecked) {
                      setState(() {
                        if (isChecked ?? false) {
                          selectedValue = item;
                          widget.onSelect(item); // Notify parent widget
                        }
                      });
                      Navigator.pop(context); // Close popup after selection
                      this.setState(() {}); // Update main dropdown UI
                    },
                    activeColor: Colors.blue, // Tick box color
                  ),
                  onTap: () {
                    setState(() {
                      selectedValue = item;
                      widget.onSelect(item);
                    });
                    Navigator.pop(context);
                    this.setState(() {});
                  },
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
