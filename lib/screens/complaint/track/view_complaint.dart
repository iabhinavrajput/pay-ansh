import 'package:flutter/material.dart';
import 'package:payansh/constants/dimensions.dart';
import 'package:payansh/theme/custom_themes/text_theme.dart';
import 'package:payansh/widgets/title_appbar.dart';
import 'package:timeline_tile/timeline_tile.dart';

class ViewComplaint extends StatefulWidget {
  const ViewComplaint({super.key});

  @override
  State<ViewComplaint> createState() => _ViewComplaintState();
}

class _ViewComplaintState extends State<ViewComplaint> {
  final List<Map<String, String>> complaintStatuses = [
    {"status": "Complaint Registered Successfully", "dateTime": "12th January,2025 10:00 am"},
    {"status": "In Progress", "dateTime": "2025-03-26 02:30 PM"},
    {"status": "Resolved", "dateTime": "2025-03-27 05:00 PM"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleAppBar(
        height: Dimensions.dynamicHeight(context, 0.15),
        title: "View Complaint",
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: complaintStatuses.asMap().entries.map((entry) {
            final index = entry.key;
            final status = entry.value;

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Timeline Indicator (Dot)
                Column(
                  children: [

                    Container(
                      margin: EdgeInsets.all(6),
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: index == complaintStatuses.length - 1
                            ? Colors.green
                            : Color(0xffF26727),
                        shape: BoxShape.circle,
                      ),
                    ),
                    if (index != complaintStatuses.length - 1)
                      Container(
                        width: 2,
                        height: 40,
                        color: Color(0x40F26727),
                      ),
                  ],
                ),
                const SizedBox(width: 10), // Space between dot and text

                // Status & DateTime
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      status["status"]!,
                      style: TTextTheme.lightTextTheme.bodyMedium
                    ),
                    SizedBox(height: 5),
                    Text(
                      status["dateTime"]!,
                      style:TextStyle(color: Color(0xffCC5A5A5B),fontSize: Dimensions.dynamicWidth(context, 0.027))
                    ),
                    SizedBox(height: Dimensions.dynamicHeight(context, 0.02)), // Spacing between rows
                  ],
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
