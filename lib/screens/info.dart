import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      appBar: TitleAppBar(height: 60, title: title),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child:
              Text(
                content,
                style: const TextStyle(fontSize: 16, color: Colors.black87),
           
        ),
      ),
      )
    );
  }
}
