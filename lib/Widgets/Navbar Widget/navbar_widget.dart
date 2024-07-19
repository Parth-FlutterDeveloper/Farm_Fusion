import 'package:farm_booking_app/Screens/Nav%20Screen/booked_screen.dart';
import 'package:farm_booking_app/Screens/Nav%20Screen/favorite_screen.dart';
import 'package:farm_booking_app/Screens/Nav%20Screen/home_screen.dart';
import 'package:farm_booking_app/Screens/Nav%20Screen/profile_screen.dart';
import 'package:flutter/material.dart';

class NavbarWidget extends StatefulWidget {
  const NavbarWidget({super.key});

  @override
  State<NavbarWidget> createState() => _NavbarWidgetState();
}

class _NavbarWidgetState extends State<NavbarWidget> {

  int selectedIndex = 0;

  final screens = [
    HomeScreen(),
    FavoriteScreen(),
    BookedScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: screens[selectedIndex],
      bottomNavigationBar: Container(
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.green,
          selectedLabelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
            fontFamily: "LocalFont"
          ),
          unselectedLabelStyle: TextStyle(
              fontFamily: "LocalFont",
              fontSize: 14
          ),
          currentIndex: selectedIndex,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home",),
            BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorits"),
            BottomNavigationBarItem(icon: Icon(Icons.book), label: "Booked"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ],
        ),
      ),
    );
  }
}
