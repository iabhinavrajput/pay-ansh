import 'package:flutter/material.dart';
import 'package:payansh/constants/app_colors.dart';
import 'package:payansh/constants/dimensions.dart';
import 'package:payansh/constants/style_constants.dart';
import 'package:payansh/controllers/dropdown_controller.dart';
import 'package:payansh/theme/custom_themes/text_theme.dart';

class CustomDropdown extends StatefulWidget {
  final String title;
  final List<String> options;

  const CustomDropdown({required this.title, required this.options, Key? key})
      : super(key: key);

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  late DropdownController controller;

  @override
  void initState() {
    super.initState();
    controller = DropdownController();
    controller.setItems(widget.options);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            _showDropdownPopup(context);
          },
          child: Container(
            height: Dimensions.dynamicHeight(context, 0.06),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Color(0x33D9D9DA),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.title, style: TTextTheme.greymediumText),
                Icon(Icons.keyboard_arrow_down,
                    color: Color(0xffB8B8BC),
                    size: Dimensions.dynamicWidth(context, 0.07)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showDropdownPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        titlePadding: EdgeInsets.zero, // Remove default padding
        contentPadding: EdgeInsets.symmetric(
            horizontal: 16, vertical: 10), // Adjust content padding
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity, // Take full width
              padding: EdgeInsets.symmetric(
                  vertical: 12, horizontal: 16), // Add padding
              decoration: BoxDecoration(
                gradient: AppColors.userLetterBg,
                borderRadius: BorderRadius.vertical(
                    top: Radius.circular(10)), // Rounded top corners
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Select Complaint Type",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: Dimensions.dynamicWidth(
                          context,
                          0.04,
                        ),
                        fontWeight: FontWeight.w600),
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
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: controller.items.map((item) {
              return CheckboxListTile(
                title: Text(item,
                    style: TextStyle(fontSize: 16, color: Colors.black87)),
                value: controller.selectedItems.contains(item),
                onChanged: (isChecked) {
                  setState(() {
                    controller.toggleSelection(item);
                  });
                },
                controlAffinity: ListTileControlAffinity.trailing,
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
