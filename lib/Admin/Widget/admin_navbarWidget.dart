import 'package:farm_booking_app/Admin/Screens/adminShowBookedFarm.dart';
import 'package:farm_booking_app/Admin/Screens/admin_homeScreen.dart';
import 'package:farm_booking_app/Admin/Screens/admin_profileScreen.dart';
import 'package:flutter/material.dart';

class AdminNavbarWidget extends StatefulWidget {
  const AdminNavbarWidget({super.key});

  @override
  State<AdminNavbarWidget> createState() => _AdminNavbarWidgetState();
}

class _AdminNavbarWidgetState extends State<AdminNavbarWidget> {

  int selectedIndex = 0;

  List<Widget> screens = [
    AdminHomeScreen(),
    AdminShowBookedFarm(),
    AdminProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: screens[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.green,
        selectedLabelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
            fontFamily: "LocalFont"
        ),
        unselectedLabelStyle: TextStyle(
            fontFamily: "LocalFont",
            fontSize: 12,
            fontWeight: FontWeight.bold
        ),
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home",),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: "Booked",),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
