
import 'package:flutter/material.dart';

class GridItem extends StatelessWidget {
  final String title;
  final IconData icon;

  GridItem({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 40, color: Colors.blue),
        SizedBox(height: 5),
        Text(title, textAlign: TextAlign.center),
      ],
    );
  }
}
