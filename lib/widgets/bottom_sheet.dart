import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:payansh/constants/dimensions.dart';
import 'package:payansh/theme/custom_themes/text_theme.dart';
import 'package:payansh/widgets/gradient_button.dart';

class ConfirmationBottomSheet extends StatelessWidget {
  final String description;
  final String? title;
  final String? message;
  final String buttonText;

  const ConfirmationBottomSheet({
    Key? key,
    required this.description,
    this.title,
    this.message,
    this.buttonText = "OK",
  }) : super(key: key);

  static void show(
    BuildContext context, {
    required String description,
    String? title,
    String? message,
    String buttonText = "OK",
  }) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      builder: (context) {
        return ConfirmationBottomSheet(
          title: title,
          description: description,
          message: message,
          buttonText: buttonText,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (title != null) ...[
            SizedBox(
              height: Dimensions.dynamicHeight(context, 0.05),
            ),
            Text(
              title!,
              style: TextStyle(
                  color: Colors.green,
                  fontSize: Dimensions.dynamicWidth(context, 0.045),
                  fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: Dimensions.dynamicHeight(context, 0.015)),
          ],
          Text(
            description,
            style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: Dimensions.dynamicWidth(context, 0.026)),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: Dimensions.dynamicHeight(context, 0.015)),
          if (message != null) ...[
            const SizedBox(height: 8),
            Text(
              message!,
              style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: Dimensions.dynamicWidth(context, 0.026)),
              textAlign: TextAlign.center,
            ),
          ],
          SizedBox(height: Dimensions.dynamicHeight(context, 0.03)),
          GestureDetector(
            child: Container(
              decoration: BoxDecoration(
                  color: Color(0x335A5A5B),
                  borderRadius: BorderRadius.circular(5)),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.dynamicWidth(context, 0.05),
                    vertical: Dimensions.dynamicWidth(context, 0.03)),
                child: Text("Ok, Got it!",style:TextStyle(color: Color(0xff5A5A5B),fontWeight: FontWeight.bold),),
              ),
            ),
          ),
          SizedBox(
            height: Dimensions.dynamicHeight(context, 0.05),
          ),
        ],
      ),
    );
  }
}
