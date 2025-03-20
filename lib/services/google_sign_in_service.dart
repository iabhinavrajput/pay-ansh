import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:payansh/constants/api_endpoints.dart';
import 'package:payansh/constants/app_constants.dart';
import 'package:payansh/screens/device_info.dart';
import 'package:payansh/utils/local_storage.dart';

class GoogleSignInService {
  static final GoogleSignInService _instance = GoogleSignInService._internal();
  factory GoogleSignInService() => _instance;
  GoogleSignInService._internal();

  static final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
    serverClientId: '785964433867-2ft4l1rb75b9tq79urpd5f18jfmjdfr6.apps.googleusercontent.com',
  );

  static bool _isSigningIn = false;
  static final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  static Future<Map<String, dynamic>> signInWithGoogle() async {
    if (_isSigningIn) {
      return {'success': false, 'message': 'Sign-in already in progress'};
    }

    _isSigningIn = true;
    isLoading.value = true; // Start loading

    try {
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account == null) {
        _isSigningIn = false;
        isLoading.value = false;
        return {'success': false, 'message': 'Sign-in cancelled by user'};
      }

      final String? serverAuthCode = account.serverAuthCode;
      if (serverAuthCode == null) {
        _isSigningIn = false;
        isLoading.value = false;
        return {'success': false, 'message': 'No Server Auth Code retrieved'};
      }

      // Get device information
      final deviceInfo = await DeviceInfoHelper.getDeviceInfo();

      // Send Auth Code to backend
      final response = await http.post(
        Uri.parse(ApiEndpoints.googleAuth),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'authCode': serverAuthCode,
          'deviceInfo': deviceInfo,
        }),
      );

      _isSigningIn = false;
      isLoading.value = false; // Stop loading

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        String accessToken = data["data"]["tokens"]["accessToken"];
        String refreshToken = data["data"]["tokens"]["refreshToken"];

        // Store tokens
        await LocalStorage.saveUserToken(accessToken);
        await LocalStorage.saveRefreshToken(refreshToken);

        // Assign global auth token
        AppConstants.authToken = accessToken;

        return {'success': true, "message": data["message"]};
      } else {
        return {'success': false, 'message': 'Backend error: ${response.body}'};
      }
    } catch (error) {
      _isSigningIn = false;
      isLoading.value = false;
      return {'success': false, 'message': 'Sign-In failed: $error'};
    }
  }

  static Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
    } catch (error) {
      print('Error signing out: $error');
    }
  }
}
