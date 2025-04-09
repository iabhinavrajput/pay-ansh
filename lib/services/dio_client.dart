import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:payansh/constants/api_endpoints.dart';
import 'package:payansh/constants/app_constants.dart';
import 'package:payansh/utils/local_storage.dart';
import 'package:payansh/utils/snackbar_util.dart';
import 'package:get/get.dart';
import 'package:payansh/screens/login_screen.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();
  factory DioClient() => _instance;
  DioClient._internal() {
    _dio = Dio(BaseOptions(
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        "Content-Type": "application/json",
      },
    ));

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        String? token = await LocalStorage.getUserToken();
        if (token != null) {
          options.headers["Authorization"] = "Bearer $token";
        }
        return handler.next(options);
      },
      onError: (DioError error, handler) async {
        if (error.response?.statusCode == 401) {
          final refreshed = await _refreshToken();
          if (refreshed) {
            // Retry original request
            final requestOptions = error.requestOptions;
            String? newToken = await LocalStorage.getUserToken();
            if (newToken != null) {
              requestOptions.headers["Authorization"] = "Bearer $newToken";
            }

            try {
              final retryResponse = await _dio.fetch(requestOptions);
              return handler.resolve(retryResponse);
            } catch (e) {
              return handler.reject(DioError(
                  requestOptions: requestOptions,
                  error: "Retry failed: $e",
                  type: DioErrorType.badResponse));
            }
          } else {
            return handler.reject(error);
          }
        }
        return handler.next(error);
      },
    ));
  }

  late Dio _dio;

  Dio get dio => _dio;

  Future<bool> _refreshToken() async {
    String? refreshToken = await LocalStorage.getRefreshToken();
    if (refreshToken == null) {
      _handleInvalidSession();
      return false;
    }

    try {
      final response = await Dio().post(
        ApiEndpoints.refreshtoken,
        data: jsonEncode({"refreshToken": refreshToken}),
        options: Options(headers: {
          "Content-Type": "application/json",
        }),
      );

      if (response.statusCode == 200 &&
          response.data["status"] == "success") {
        final newAccessToken = response.data["data"]["accessToken"];
        final newRefreshToken = response.data["data"]["refreshToken"];

        await LocalStorage.saveUserToken(newAccessToken);
        await LocalStorage.saveRefreshToken(newRefreshToken);
        AppConstants.authToken = newAccessToken;
        return true;
      } else if (response.statusCode == 401 &&
          response.data["message"] == "Invalid refresh token") {
        _handleInvalidSession();
      }

      return false;
    } catch (e) {
      print("Token refresh failed: $e");
      return false;
    }
  }

  void _handleInvalidSession() {
    LocalStorage.clearUserToken();
    AppConstants.authToken = null;
    Get.snackbar(
      "Session Expired",
      "Your session expired. Please login again.",
      snackPosition: SnackPosition.BOTTOM,
    );
    Get.offAll(() => LoginScreen());
  }
}
