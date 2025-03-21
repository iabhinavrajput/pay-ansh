import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payansh/constants/dimensions.dart';
import 'package:payansh/theme/custom_themes/text_theme.dart';
import 'package:payansh/widgets/title_appbar.dart';

class Info extends StatelessWidget {
  final String title;
  final String content;

  const Info({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleAppBar(height:Dimensions.dynamicHeight(context, 0.15), title: title),
      body: Padding(
        padding:  EdgeInsets.all(Dimensions.dynamicWidth(context, 0.09)),
        child: SingleChildScrollView(
          child:
              Text(
                content,
                style: TTextTheme.lightTextTheme.bodyMedium,
           
        ),
      ),
      )
    );
  }
}
