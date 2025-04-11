import 'package:flutter/material.dart';
import 'package:payansh/constants/dimensions.dart';
import 'package:payansh/widgets/icon_container.dart';
import 'dart:math';

class RechargeGrid extends StatelessWidget {
  final List<Map<String, dynamic>> iconData;

  const RechargeGrid({
    Key? key,
    required this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double maxRowWidth = _calculateMaxRowWidth(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < iconData.length; i += 4)
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: SizedBox(
              width: maxRowWidth,
              child: Row(
                mainAxisAlignment:
                    _getMainAxisAlignment(min(4, iconData.length - i)),
                children: [
                  for (int j = i; j < i + 4 && j < iconData.length; j++)
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.dynamicHeight(context, 0.015),
                        ),
                        child: IconContainer(
                          imagePath: iconData[j]['image']!,
                          label: iconData[j]['label']!,
                          onTap: () {
                            final screen = iconData[j]['screen'];
                            if (screen != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => screen),
                              );
                            } else {
                              _showComingSoonPopup(context);
                            }
                          },
                        ),
                      ),
                    ),
                  if (iconData.length - i < 4)
                    for (int k = 0; k < (4 - (iconData.length - i)); k++)
                      Expanded(child: SizedBox()),
                ],
              ),
            ),
          ),
      ],
    );
  }

  void _showComingSoonPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Coming Soon"),
        content: Text("This feature will be available soon!"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  MainAxisAlignment _getMainAxisAlignment(int itemsInRow) {
    if (itemsInRow == 2) {
      return MainAxisAlignment.start;
    }
    return MainAxisAlignment.center;
  }

  double _calculateMaxRowWidth(BuildContext context) {
    double iconWidth = Dimensions.dynamicHeight(context, 0.12);
    double spacing = Dimensions.dynamicHeight(context, 0.015) * 2 * 3;
    return (iconWidth * 4) + spacing;
  }
}
