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
              width: maxRowWidth, // Ensure all rows have the same width
              child: Row(
                mainAxisAlignment:
                    _getMainAxisAlignment(min(4, iconData.length - i)),
                children: [
                  for (int j = i; j < i + 4 && j < iconData.length; j++)
                    Expanded(
                      // Ensure equal spacing
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.dynamicHeight(context, 0.015),
                        ),
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
                    ),
                  if (iconData.length - i < 4) // Fill empty space for alignment
                    for (int k = 0; k < (4 - (iconData.length - i)); k++)
                      Expanded(
                          child:
                              SizedBox()), // Empty space to balance alignment
                ],
              ),
            ),
          ),
      ],
    );
  }

  /// Ensures alignment of rows based on number of items
  MainAxisAlignment _getMainAxisAlignment(int itemsInRow) {
    if (itemsInRow == 2) {
      return MainAxisAlignment.start; // 2 items should be left-aligned
    }
    return MainAxisAlignment.center; // 3 or 4 items should be centered
  }

  /// Calculates the maximum width for a row with 4 items
  double _calculateMaxRowWidth(BuildContext context) {
    double iconWidth = Dimensions.dynamicHeight(
        context, 0.12); // Approximate width of IconContainer
    double spacing = Dimensions.dynamicHeight(context, 0.015) *
        2 *
        3; // Padding between icons
    return (iconWidth * 4) + spacing; // Full width of a 4-item row
  }
}
