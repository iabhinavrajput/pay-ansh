import 'package:get/get.dart';

class SliderController extends GetxController {
  RxInt currentIndex = 0.obs;

  final List<String> sliderImages = [
    'assets/login_slider/Hote-booking-Thumbnail.png',
    'assets/login_slider/Flight-Booking-Thumbnail.png',
    'assets/login_slider/BBPS-thumbnail.png',
  ];

  void updateIndex(int index) {
    currentIndex.value = index;
  }
}
