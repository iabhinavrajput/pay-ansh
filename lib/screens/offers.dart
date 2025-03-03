import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:payansh/widgets/app_bar.dart';
import 'package:payansh/widgets/title_appbar.dart';

class Offers extends StatefulWidget {
  const Offers({super.key});

  @override
  State<Offers> createState() => _OffersState();
}

class _OffersState extends State<Offers> {
  final List<String> offerImages = [
    'assets/offers/offer1.png',
    'assets/offers/offer2.png',
    'assets/offers/offer3.png',
    'assets/offers/offer4.png',
    'assets/offers/offer5.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleAppBar(height: 60, title: "Offers & Cashback"),
      body: ListView.builder(
        padding: const EdgeInsets.only(top: 16,left: 16,right: 16, bottom: 150),
        itemCount: offerImages.length,
        itemBuilder: (context, index) {
          return Padding(
            padding:
                const EdgeInsets.only(bottom: 16), // Spacing between images
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                offerImages[index],
                // width: double.infinity,
                // height: 200, // Set a reasonable height
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
      
    );
  }
}
