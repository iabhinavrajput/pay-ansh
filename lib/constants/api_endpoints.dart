class ApiEndpoints {
  static const String baseUrl = "http://api.payansh.com/api/auth";
  static const String baseUrl2 = "http://api.payansh.com/api";

  static const String login = "$baseUrl/login";
  static const String refreshtoken = "$baseUrl/refresh-token";
  static const String forgotPassword = "$baseUrl/forgot-password";
  static const String resetPassword = "$baseUrl/reset-password";
  static const String verifyOTP = "$baseUrl/verify-reset-otp";
  static const String profileEndpoint = '$baseUrl2/profile/user/profile';
  static const String profileUpdate = '$baseUrl2/profile/user/profile-update';
  static const String uploadProfilePicture =
      '$baseUrl2/profile/upload-profile-picture';

  static const String googleAuth = '$baseUrl/google/verify';
  static const String deleteAccountInitiate = '$baseUrl2/users/delete-account/initiate';
  static const String deleteAccountConfirm = '$baseUrl2/users/delete-account/confirm';
  static const String complaintTypesReason = '$baseUrl2/complaints/typesandreasons';
}
