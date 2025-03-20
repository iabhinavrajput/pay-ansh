import 'package:get/get.dart';

class SliderController extends GetxController {
  RxInt currentIndex = 0.obs;

  final List<String> sliderImages = [
    'assets/login_slider/Hote-booking-Thumbnail.png',
    'assets/login_slider/Flight-Booking-Thumbnail.png',
    'assets/login_slider/BBPS-thumbnail.png',
  ];

  final List<String> bannerImages = [
    'assets/banner/slider1.png',
    'assets/banner/slider3.png',
    'assets/banner/slider2.png',
    'assets/banner/slider4.png',
  ];

  final List<String> flightOffer = [
    'assets/flight_Offer/flightOffer1.png',
    'assets/flight_Offer/flightOffer2.png',
    'assets/flight_Offer/flightOffer3.png',
  ];
  


  void updateIndex(int index) {
    currentIndex.value = index;
  }
}
