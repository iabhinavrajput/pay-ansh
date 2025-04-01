import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:kyc_workflow/digio_config.dart' as workflow;
import 'package:kyc_workflow/environment.dart';
import 'package:kyc_workflow/gateway_event.dart';
import 'package:kyc_workflow/kyc_workflow.dart';
import 'package:payansh/components/custom_app_bar_kyc.dart';
import 'package:payansh/constants/dimensions.dart';

class WorkflowScreen extends StatefulWidget {
  @override
  State<WorkflowScreen> createState() => _WorkflowScreenState();
}

class _WorkflowScreenState extends State<WorkflowScreen> {
  String _workflowResult = 'Starting KYC Workflow...';
  late String kid;
  late String accessToken;
  late String email;
  late String status;
  late String docType;

  @override
  void initState() {
    super.initState();

    // Retrieve arguments passed to this screen
    final args = Get.arguments as Map<String, dynamic>;
    print("Args:$args");
    kid = args["kid"];
    accessToken = args["accessToken"];
    email = args["email"];
    status = args["status"] ?? "pending";
    docType = args["docType"] ?? "pan"; // Default to PAN

    startKycWorkflow();
  }

  /// Starts the Digio KYC Workflow and extracts user details
  Future<void> startKycWorkflow() async {
    dynamic workflowResult;
    try {
      // Configure Digio KYC
      var digioConfig = workflow.DigioConfig();
      digioConfig.theme.primaryColor = "#1E900F";
      digioConfig.logo =
          "https://www.gstatic.com/mobilesdk/160503_mobilesdk/logo/2x/firebase_28dp.png";
      digioConfig.environment = Environment.PRODUCTION;

      final _kycWorkflowPlugin = KycWorkflow(digioConfig);

      // Listen for Digio Gateway Events (For Debugging)
      _kycWorkflowPlugin.setGatewayEventListener((GatewayEvent? gatewayEvent) {
        print("Gateway Funnel Event: $gatewayEvent");
      });

      // Start KYC workflow
      workflowResult =
          await _kycWorkflowPlugin.start(kid, email, accessToken, null);

      print('Raw Workflow Result: ${workflowResult.toString()}');
      print('workflowResult Type: ${workflowResult.runtimeType}');

      // Extract user details
      extractUserDetails(workflowResult);
    } catch (e) {
      workflowResult = 'Failed to start KYC workflow.';
      print("Error: $e");

      setState(() {
        _workflowResult = "Error: Unable to fetch KYC details.";
      });
    }
  }

  /// Extracts and displays user details from the workflow result
  void extractUserDetails(dynamic workflowResult) {
    try {
      var documentId = workflowResult.documentId ?? "Not Available";
      var message = workflowResult.message ?? "Not Available";
      var code = workflowResult.code ?? "Not Available";

      // Logging extracted details
      print("✅ Extracted User Details:");
      print("📜 Document ID: $documentId");
      print("📬 Message: $message");
      print("🔢 Code: $code");

      // Updating UI
      setState(() {
        _workflowResult = '''
      Document ID: $documentId
      Message: $message
      Code: $code
      ''';
      });
      print("Extracted Data: $_workflowResult");
    } catch (e) {
      print("Error extracting user details: $e");

      setState(() {
        _workflowResult = "Error: Could not extract user details.";
      });
    }
  }

  Widget _buildStatusUI({
    required String text,
    required Color color,
    required IconData icon,
    required String message,
    required String documentType, // Added parameter for document type
  }) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Upload Your $documentType*", // Dynamic document type
                style: TextStyle(color: Colors.black)),
            Text(text, style: TextStyle(color: color)),
          ],
        ),
        SizedBox(height: Dimensions.dynamicHeight(context, 0.015)),
        Container(
          width: Dimensions.dynamicWidth(context, 1),
          height: Dimensions.dynamicHeight(context, 0.2),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color.withOpacity(0.2), // Light background
                ),
                child: Icon(icon, color: color, size: 40),
              ),
              SizedBox(height: Dimensions.dynamicHeight(context, 0.01)),
              Text(message, style: TextStyle(color: Color(0xff5A5A5B))),
            ],
          ),
        )
      ],
    );
  }

  Widget _getStatusUI(String documentType) {
    // Accepts documentType parameter
    switch (status.toLowerCase()) {
      case "pending":
        return _buildStatusUI(
          text: "Pending",
          color: Colors.orange,
          icon: HugeIcons.strokeRoundedClock02,
          message: "Your $documentType verification is pending.",
          documentType: documentType,
        );
      case "requested":
        return _buildStatusUI(
          text: "Requested",
          color: Colors.blue,
          icon: HugeIcons.strokeRoundedCircleArrowRight01,
          message: "Your $documentType verification request has been sent.",
          documentType: documentType,
        );
      case "rejected":
        return _buildStatusUI(
          text: "Rejected",
          color: Colors.red,
          icon: HugeIcons.strokeRoundedCancelCircleHalfDot,
          message: "Your $documentType verification was rejected.",
          documentType: documentType,
        );
      case "approved":
        return _buildStatusUI(
          text: "Verified",
          color: const Color(0xff47C546),
          icon: HugeIcons.strokeRoundedCheckmarkCircle04,
          message: "Your $documentType was verified successfully.",
          documentType: documentType,
        );
      default:
        return _buildStatusUI(
          text: "Unknown",
          color: Colors.grey,
          icon: HugeIcons.strokeRoundedHelpCircle,
          message: "Status is not available.",
          documentType: documentType,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBarKYC(
        title: "Upload Documents",
        description:
            "Please note that your Aadhaar number\nto be verified during KYC verification",
      ),
      body: Container(
        margin: const EdgeInsets.all(30),
        child: _getStatusUI(docType), // Dynamic status UI
      ),
    );
  }
}
