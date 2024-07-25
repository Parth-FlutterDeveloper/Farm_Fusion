import 'package:farm_booking_app/Widgets/Profile%20Widget/profile_Image_widget.dart';
import 'package:farm_booking_app/Widgets/Profile%20Widget/profile_option_widget.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green.shade300,
        title: Text("Profile",style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            fontFamily: "LocalFont",
            color: Colors.black,
            letterSpacing: 1.5
        ),),
      ),
       body: Column(
         children:  [
           // Center(
           //   child: Text("Profile",style: TextStyle(
           //       fontSize: 33,
           //       fontWeight: FontWeight.bold,
           //       fontFamily: "LocalFont",
           //       letterSpacing: 1.5,
           //       color: Colors.green
           //   ),),
           // ),
           SizedBox(height: 90),
           ProfileImageWidget(),
           SizedBox(height: 25),

           ProfileOptionWidget(
             text: "Favourite",
             color: Colors.green.shade100,
             icon: Icon(Icons.favorite),
             onTap: () {
               print("sddddddddddddd");
             },
           ),
           SizedBox(height: 25),
           ProfileOptionWidget(
             text: "Booked Farm",
             color: Colors.green.shade100,
             icon: Icon(Icons.book),
             onTap: () {
               print("sddddddddddddd");
             },
           ),
           SizedBox(height: 25),
           ProfileOptionWidget(
             text: "Setting",
             color: Colors.green.shade100,
             icon: Icon(Icons.settings),
             onTap: () {
               print("sddddddddddddd");
             },
           ),
           SizedBox(height: 25),
           ProfileOptionWidget(
             text: "Logout",
             color: Colors.red.shade100,
             icon: Icon(Icons.logout),
             onTap: () {
               print("sddddddddddddd");
             },
           ),
         ],
       ),
    );
  }
}
