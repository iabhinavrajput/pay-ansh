import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payansh/constants/app_colors.dart';
import 'package:payansh/controllers/splash_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _positionAnimation;
  late Animation<double> _sizeAnimation;

  final SplashController splashController = Get.put(SplashController());

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    // Position Animation: Moves logo from bottom (1.0) to top (0.2)
    _positionAnimation = Tween<double>(begin: 0.8, end: 0.5).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    // Size Animation: Gradually increases size
    _sizeAnimation = Tween<double>(begin: 50.0, end: 200.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Stack(
            children: [
              Positioned(
                top: screenHeight *
                    _positionAnimation.value, // Moves from bottom to top
                left: 0,
                right: 0,
                child: Center(
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: _sizeAnimation.value, // Changes size dynamically
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
