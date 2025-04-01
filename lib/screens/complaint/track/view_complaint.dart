import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:payansh/constants/dimensions.dart';
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
    final FlutterSecureStorage _storage = const FlutterSecureStorage();

  List<Map<String, String>> complaintStatuses = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchComplaintDetails();
  }

  Future<void> fetchComplaintDetails() async {
    final String url = "https://api.payansh.com/api/complaints";
      String? token = await _storage.read(key: "accessToken");

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data["success"]) {
          List<dynamic> complaints = data["data"]["complaints"];

          // Find the specific complaint by type_id and id
          var complaint = complaints.firstWhere(
            (c) => c["type_id"].toString() == widget.typeId && c["id"].toString() == widget.complaintId,
            orElse: () => null,
          );

          if (complaint != null) {
            setState(() {
              complaintStatuses = [
                {"status": "Complaint Registered Successfully", "dateTime": complaint["created_at"]},
                {"status": "Status: ${complaint["status"]}", "dateTime": complaint["updated_at"]},
              ];
              isLoading = false;
            });
          } else {
            setState(() {
              errorMessage = "No complaint found for the given details.";
              isLoading = false;
            });
          }
        } else {
          setState(() {
            errorMessage = "Failed to fetch complaints.";
            isLoading = false;
          });
        }
      } else {
        setState(() {
          errorMessage = "Server error. Please try again later.";
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = "Something went wrong. Please check your connection.";
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleAppBar(
        height: Dimensions.dynamicHeight(context, 0.15),
        title: "View Complaint",
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? Center(child: Text(errorMessage, style: TextStyle(color: Colors.red)))
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: complaintStatuses.asMap().entries.map((entry) {
                      final index = entry.key;
                      final status = entry.value;

                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Container(
                                margin: EdgeInsets.all(6),
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                  color: index == complaintStatuses.length - 1 ? Colors.green : Color(0xffF26727),
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
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                status["status"]!,
                                style: TTextTheme.lightTextTheme.bodyMedium,
                              ),
                              SizedBox(height: 5),
                              Text(
                                status["dateTime"]!,
                                style: TextStyle(
                                  color: Color(0xffCC5A5A5B),
                                  fontSize: Dimensions.dynamicWidth(context, 0.027),
                                ),
                              ),
                              SizedBox(height: Dimensions.dynamicHeight(context, 0.02)),
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
