import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SelectOperatorScreen extends StatelessWidget {
  final List<Map<String, String>> operators = [
    {'name': 'Airtel', 'image': 'assets/mobile_logo/airtel_logo.png'},
    {
      'name': 'VideoconIdea Prepaid',
      'image': 'assets/mobile_logo/videocon-logo.png'
    },
    {
      'name': 'Jio Prepaid',
      'image': 'assets/mobile_logo/reliance_jio_logo.png'
    },
    {'name': 'BSNL Prepaid', 'image': 'assets/mobile_logo/BSNL-logo.png'},
    {'name': 'MTNL Delhi Prepaid', 'image': 'assets/mobile_logo/MTNL-logo.png'},
    {
      'name': 'MTNL Mumbai Prepaid',
      'image': 'assets/mobile_logo/MTNL-logo.png'
    },
  ];

  SelectOperatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Select Operator"),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context); // Closes the screen
          },
        ),
      ),
      body: ListView.builder(
        itemCount: operators.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.asset(
              operators[index]["image"]!,
              width: 30,
              height: 30,
            ),
            title: Text(
              operators[index]["name"]!,
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  color: Color(0xff5A5A5B)),
            ),
            onTap: () {
              // Pass selected operator back to the previous screen
              Navigator.pop(context, operators[index]);
            },
          );
        },
      ),
    );
  }
}
