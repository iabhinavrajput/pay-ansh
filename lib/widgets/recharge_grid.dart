import 'package:flutter/material.dart';
import 'package:payansh/constants/dimensions.dart';
import 'package:payansh/widgets/icon_container.dart';

class RechargeGrid extends StatelessWidget {
  final List<Map<String, dynamic>> iconData;

  const RechargeGrid({Key? key, required this.iconData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < iconData.length; i += 4)
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                for (int j = i; j < i + 4 && j < iconData.length; j++)
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: Dimensions.dynamicHeight(context, 0.01)),
                    child: IconContainer(
                      imagePath: iconData[j]['image']!,
                      label: iconData[j]['label']!,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => iconData[j]['screen'],
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}