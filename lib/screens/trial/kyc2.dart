import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyc_workflow/digio_config.dart' as workflow;
import 'package:kyc_workflow/environment.dart';
import 'package:kyc_workflow/gateway_event.dart';
import 'package:kyc_workflow/kyc_workflow.dart';

class WorkflowScreen extends StatefulWidget {
  @override
  State<WorkflowScreen> createState() => _WorkflowScreenState();
}

class _WorkflowScreenState extends State<WorkflowScreen> {
  String _workflowResult = 'Starting KYC Workflow...';
  late String kid;
  late String accessToken;
  late String email;

  @override
  void initState() {
    super.initState();

    // Retrieve arguments passed to this screen
    final args = Get.arguments as Map<String, dynamic>;
    kid = args["kid"];
    accessToken = args["accessToken"];
    email = args["email"];

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
      workflowResult = await _kycWorkflowPlugin.start(kid, email, accessToken, null);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KYC Workflow'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Result: \n$_workflowResult',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
