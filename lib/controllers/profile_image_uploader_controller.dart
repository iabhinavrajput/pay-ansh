import 'dart:convert';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:payansh/constants/api_endpoints.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import 'package:payansh/utils/snackbar_util.dart';

class ProfileImageUploaderController {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  final ImagePicker _picker = ImagePicker();

  File? _image;

  /// Picks an image from the gallery
  Future<File?> pickImage() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (pickedFile != null) {
      _image = File(pickedFile.path);
      return _image;
    }
    return null;
  }

  /// Uploads the selected image to the API
  Future<bool> uploadImage(File imageFile) async {
    var url = Uri.parse(ApiEndpoints.profilePictureUpload);
    String? token = await _storage.read(key: "accessToken");

    if (token == null) {
      print("❌ Error: No access token found!");
      return false;
    }

    var request = http.MultipartRequest("POST", url);
    request.headers["Authorization"] = "Bearer $token";

    var mimeType = lookupMimeType(imageFile.path);
    var multipartFile = await http.MultipartFile.fromPath(
      'profilePicture',
      imageFile.path,
      contentType:
          mimeType != null ? MediaType.parse(mimeType) : null, // ✅ Fix applied
    );

    request.files.add(multipartFile);

    try {
      var response = await request.send();
      var responseBody = await http.Response.fromStream(response);
      
      if (response.statusCode == 200) {
        final responseJson = jsonDecode(responseBody.body);
        showSnackbar(
            title: "Success", message: responseJson["message"], isSuccess: true);
        return true;
      } else {
        final responseJson = jsonDecode(responseBody.body);
        showSnackbar(
            title: "Error", message: responseJson["message"], isSuccess: false);
        return false;
      }
    } catch (e) {
      print("❌ Error uploading image: $e");
      return false;
    }
  }
}
