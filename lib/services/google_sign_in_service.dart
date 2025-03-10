// import 'dart:convert';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:http/http.dart' as http;

// class GoogleSignInService {
//   static final GoogleSignIn _googleSignIn = GoogleSignIn(
//     scopes: ['email', 'profile'],
//     serverClientId: '785964433867-2ft4l1rb75b9tq79urpd5f18jfmjdfr6.apps.googleusercontent.com'
//   );

//   /// Sign in with Google and authenticate with backend
//   static Future<Map<String, dynamic>> signInWithGoogle() async {
//     try {
//       // Trigger Google Sign-In
//       final GoogleSignInAccount? account = await _googleSignIn.signIn();
//       if (account == null) {
//         return {'success': false, 'message': 'Sign-in cancelled by user'};
//       }

//       // Obtain authentication details
//       final GoogleSignInAuthentication auth = await account.authentication;
//       final String? idToken = auth.idToken;

//       // print('ID Token: $idToken');
//       // print('Access Token: ${auth.accessToken}');
//       // print('Server Auth Code: ${auth.serverAuthCode}');
//       print('ID Token: ${auth.idToken}');
//       // print("GoogleSignInAuthentication: $auth");
//       print("GoogleSignInAccount: $account");

//       if (idToken == null) {
//         return {'success': false, 'message': 'No ID token retrieved'};
//       }

//       // Send ID token to your backend for verification
//       final response = await http.post(
//         Uri.parse(''),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({'id_token': idToken}),
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         return {
//           'success': true,
//           'data': data,
//         };
//       } else {
//         return {
//           'success': false,
//           'message': 'Backend error: ${response.body}',
//         };
//       }
//     } catch (error) {
//       print('Google Sign-In failed: $error');
//       return {
//         'success': false,
//         'message': 'Sign-In failed: $error',
//       };
//     }
//   }

//   /// Optional: Sign out from Google
//   static Future<void> signOut() async {
//     try {
//       await _googleSignIn.signOut();
//       print('User signed out successfully');
//     } catch (error) {
//       print('Error signing out: $error');
//     }
//   }
// }



import 'dart:convert';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

class GoogleSignInService {
  static final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
    serverClientId: '785964433867-2ft4l1rb75b9tq79urpd5f18jfmjdfr6.apps.googleusercontent.com'
  );

  /// Sign in with Google and authenticate with backend
  static Future<Map<String, dynamic>> signInWithGoogle() async {
    try {
      // Trigger Google Sign-In
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account == null) {
        return {'success': false, 'message': 'Sign-in cancelled by user'};
      }

      // Obtain authentication details
      // final GoogleSignInAuthentication auth = await account.authentication;
      // final String? serverAuthCode = auth.serverAuthCode;
      final String? serverAuthCode = account.serverAuthCode;

      print('GoogleSignInAccount: ${account.serverAuthCode}');
      //  print("GoogleSignInAccount: $account");
      print('Server Auth Code: $serverAuthCode');

      if (serverAuthCode == null) {
        return {'success': false, 'message': 'No Server Auth Code retrieved'};
      }

      // Send serverAuthCode to your backend for verification
      final response = await http.get(
        Uri.parse('http://apipyaansh.nxgtech.io/api/auth/google/callback?code=${account.serverAuthCode}'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {
          'success': true,
          'data': data,
        };
      } else {
        return {
          'success': false,
          'message': 'Backend error: ${response.body}',
        };
      }
    } catch (error) {
      print('Google Sign-In failed: $error');
      return {
        'success': false,
        'message': 'Sign-In failed: $error',
      };
    }
  }

  /// Optional: Sign out from Google
  static Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      print('User signed out successfully');
    } catch (error) {
      print('Error signing out: $error');
    }
  }
}
