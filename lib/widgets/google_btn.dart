import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:payansh/constants/app_colors.dart';
import 'package:payansh/constants/dimensions.dart';

class GoogleBtn extends StatelessWidget {
  const GoogleBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: Dimensions.dynamicHeight(context, 0.06),
      decoration: BoxDecoration(
        color: Colors.transparent, // Makes the inside transparent
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.gradientEnd, // Border color
          width: 1, // Border thickness
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/icon/google.png",width: Dimensions.dynamicWidth(context, 0.08),),
          SizedBox(width: Dimensions.dynamicWidth(context, 0.03),),
          Text("Login with Google",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400
          ),)
        ],
      ),
    );
  }
}
