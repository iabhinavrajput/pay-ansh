import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:payansh/widgets/app_bar.dart';

class Offers extends StatefulWidget {
  const Offers({super.key});

  @override
  State<Offers> createState() => _OffersState();
}

class _OffersState extends State<Offers> {
  final List<String> offerImages = [
    'assets/offers/offer1.svg',
    'assets/offers/offer2.svg',
    'assets/offers/offer3.svg',
    'assets/offers/offer4.svg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(height: 60),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: offerImages.length,
        itemBuilder: (context, index) {
          return Padding(
            padding:
                const EdgeInsets.only(bottom: 16), // Spacing between images
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SvgPicture.asset(
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
