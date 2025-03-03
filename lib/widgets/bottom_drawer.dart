import 'package:flutter/material.dart';

class BottomNavWithDrawer extends StatefulWidget {
  const BottomNavWithDrawer({Key? key}) : super(key: key);

  @override
  _BottomNavWithDrawerState createState() => _BottomNavWithDrawerState();
}

class _BottomNavWithDrawerState extends State<BottomNavWithDrawer> {
  bool _isDrawerOpen = false;

  void _toggleBottomDrawer() {
    if (_isDrawerOpen) {
      Navigator.pop(context); // Close drawer
    } else {
      _showBottomDrawer(); // Open drawer
    }
    setState(() {
      _isDrawerOpen = !_isDrawerOpen;
    });
  }

  void _showBottomDrawer() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            // Bottom Drawer Content
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Container(
                margin: EdgeInsets.only(left: 20),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.,
                  children: [
                    Image.asset('assets/frame/bottom.png',
                        height: 50), // Example image
                    SizedBox(width: 10),
                    Text(
                      "Vendor Transfer",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
            // Floating Close Button
            // Floating Close Button
            Positioned(
              top: -70, // Adjust to properly overlap the drawer
              left: MediaQuery.of(context).size.width / 2 - 25, // Center align
              child: ClipOval(
                child: Material(
                  color: Colors.grey, // Background color
                  child: InkWell(
                    onTap: _toggleBottomDrawer,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white, // Background color
                      ),
                      child: Icon(Icons.close, color: Colors.grey, size: 28),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    ).whenComplete(() {
      setState(() {
        _isDrawerOpen = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: _toggleBottomDrawer,
      backgroundColor: _isDrawerOpen ? Colors.red : Colors.blue,
      shape: CircleBorder(),
      child: Icon(
        _isDrawerOpen ? Icons.close : Icons.add,
        color: Colors.white,
      ),
    );
  }
}
