import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:payansh/constants/dimensions.dart';
import 'package:payansh/controllers/complain_controller.dart';
import 'package:payansh/theme/custom_themes/text_theme.dart';
import 'package:payansh/widgets/title_appbar.dart';

class ViewComplaint extends StatefulWidget {
  final String typeId;
  final String complaintId;

  const ViewComplaint({super.key, required this.typeId, required this.complaintId});

  @override
  State<ViewComplaint> createState() => _ViewComplaintState();
}

class _ViewComplaintState extends State<ViewComplaint> {
  final ComplaintController _complaintController = Get.put(ComplaintController());

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _complaintController.fetchComplaintDetails(widget.typeId, widget.complaintId);
    });
  }

  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return const Color(0xffF26727);
      case 'approved':
      case 'successfully solved':
        return Colors.green;
      default:
        return const Color(0xffF26727);
    }
  }

  Widget _buildShimmerEffect() {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Container(
                    width: 2,
                    height: 40,
                    color: Colors.grey[300],
                  ),
                ],
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        width: double.infinity,
                        height: 16,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        width: 100,
                        height: 12,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleAppBar(
        height: Dimensions.dynamicHeight(context, 0.15),
        title: "View Complaint",
      ),
      body: Obx(() {
        if (_complaintController.isLoading.value) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildShimmerEffect(),
          );
        }
        if (_complaintController.errorMessage.isNotEmpty) {
          return Center(
            child: Text(
              _complaintController.errorMessage.value,
              style: const TextStyle(color: Colors.red, fontSize: 16),
            ),
          );
        }
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: _complaintController.complaintStatuses.asMap().entries.map((entry) {
              final index = entry.key;
              final status = entry.value;
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(6),
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: getStatusColor(status["status"]!),
                          shape: BoxShape.circle,
                        ),
                      ),
                      if (index != _complaintController.complaintStatuses.length - 1)
                        Container(
                          width: 2,
                          height: 40,
                          color: getStatusColor(status["status"]!).withOpacity(0.3),
                        ),
                    ],
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          status["status"]!,
                          style: TTextTheme.lightTextTheme.bodyMedium,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          status["dateTime"]!,
                          style: TextStyle(
                            color: const Color(0xffCC5A5A5B),
                            fontSize: Dimensions.dynamicWidth(context, 0.027),
                          ),
                        ),
                        SizedBox(height: Dimensions.dynamicHeight(context, 0.02)),
                      ],
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        );
      }),
    );
  }
}