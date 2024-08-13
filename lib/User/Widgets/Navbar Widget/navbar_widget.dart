import 'package:flutter/material.dart';
import 'check_login.dart';

class NavbarWidget extends StatefulWidget {
  const NavbarWidget({super.key});

  @override
  State<NavbarWidget> createState() => _NavbarWidgetState();
}

class _NavbarWidgetState extends State<NavbarWidget> {

  int selectedIndex = 0;

  List<Widget> screens = [];
  CheckLoginProcess isCheck = CheckLoginProcess();

  @override
  void initState() {
    super.initState();
    screens = isCheck.isLogin(context);
  }

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
          fontSize: 17,
          fontFamily: "LocalFont"
        ),
        unselectedLabelStyle: TextStyle(
            fontFamily: "LocalFont",
            fontSize: 14,
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
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favourits"),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: "Booked"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
