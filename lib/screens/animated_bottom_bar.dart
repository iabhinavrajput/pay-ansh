import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  int _bottomNavIndex = 0; // Default active index

  late AnimationController _fabAnimationController;
  late Animation<double> fabAnimation;
  late AnimationController _hideBottomBarAnimationController;

  final iconList = <IconData>[
    Icons.home_outlined, // Home Icon
    Icons.history_outlined, // History Icon
  ];

  @override
  void initState() {
    super.initState();

    _fabAnimationController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );

    fabAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _fabAnimationController, curve: Curves.easeIn),
    );

    _hideBottomBarAnimationController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );

    Future.delayed(Duration(milliseconds: 500), () {
      _fabAnimationController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Center(
        child: Text(
          _bottomNavIndex == 0 ? "Home Screen" : "History Screen",
          style: TextStyle(fontSize: 24),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        shape: CircleBorder(),
        backgroundColor: Colors.blue,
        child: Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Container(
        height: 0, // Increased height of bottom bar
        padding: EdgeInsets.only(bottom: 0), // Padding for better spacing
        child: AnimatedBottomNavigationBar(
          icons: iconList,
          activeIndex: _bottomNavIndex,
          gapLocation: GapLocation.center,
          notchSmoothness: NotchSmoothness.defaultEdge,
          leftCornerRadius: 18,
          rightCornerRadius: 18,
          backgroundColor: Colors.blueGrey.shade900,
          activeColor: Colors.blueAccent,
          inactiveColor: Colors.grey,
          iconSize: 30, // Increased icon size
          onTap: (index) => setState(() => _bottomNavIndex = index),
        ),
      ),
    );
  }
}
