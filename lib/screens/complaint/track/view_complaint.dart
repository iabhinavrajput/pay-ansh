import 'package:flutter/material.dart';
import 'package:payansh/constants/dimensions.dart';
import 'package:payansh/widgets/title_appbar.dart';
import 'package:timeline_tile/timeline_tile.dart';

class ViewComplaint extends StatefulWidget {
  const ViewComplaint({super.key});

  @override
  State<ViewComplaint> createState() => _ViewComplaintState();
}

class _ViewComplaintState extends State<ViewComplaint> {
  final List<Map<String, String>> complaintStatuses = [
    {"status": "Complaint Registered", "dateTime": "2025-03-25 10:00 AM"},
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
        child: ListView.builder(
          itemCount: complaintStatuses.length,
          itemBuilder: (context, index) {
            final status = complaintStatuses[index];
            return TimelineTile(
              alignment: TimelineAlign.start,
              isFirst: index == 0,
              isLast: index == complaintStatuses.length - 1,
              indicatorStyle: IndicatorStyle(
                width: 30,
                color: index == complaintStatuses.length - 1
                    ? Colors.green
                    : Colors.blue,
                indicatorXY: 0.5,
                padding: EdgeInsets.all(6),
              ),
              beforeLineStyle: LineStyle(
                color: Colors.blue,
                thickness: 3,
              ),
              endChild: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      status["status"]!,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      status["dateTime"]!,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
