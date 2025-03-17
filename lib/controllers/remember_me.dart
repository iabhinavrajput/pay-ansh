import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class RememberMeController extends GetxController {
  final box = GetStorage();
  var isRemembered = false.obs;

  String get savedEmail => box.read('email') ?? '';
  String get savedPassword => box.read('password') ?? '';

  void toggleRememberMe(bool value) {
    isRemembered.value = value;
    if (!value) {
      box.remove('email');
      box.remove('password');
    }
  }

  void saveCredentials(String email, String password) {
    if (isRemembered.value) {
      box.write('email', email);
      box.write('password', password);
    }
  }
}
