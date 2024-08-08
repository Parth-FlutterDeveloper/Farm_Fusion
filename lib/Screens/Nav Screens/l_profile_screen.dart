
// Profile Screen for Logged in Users.

import 'package:flutter/material.dart';
import '../../Widgets/Logged Profile Widget/logout_dialog.dart';
import '../../Widgets/Logged Profile Widget/profile_Image_widget.dart';
import '../../Widgets/Logged Profile Widget/profile_option_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  LogoutDialog logoutDialog = LogoutDialog();

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
           SizedBox(height: 70),
           ProfileImageWidget(),
           SizedBox(height: 40),

           ProfileOptionWidget(
             text: "Favourite",
             color: Colors.green.shade100,
             icon: Icon(Icons.favorite,size: 22),
             onTap: () {
               print("sddddddddddddd");
             },
           ),
           SizedBox(height: 30),
           ProfileOptionWidget(
             text: "Booked Farm",
             color: Colors.green.shade100,
             icon: Icon(Icons.book,size: 22),
             onTap: () {
               print("sddddddddddddd");
             },
           ),
           SizedBox(height: 30),
           ProfileOptionWidget(
             text: "Setting",
             color: Colors.green.shade100,
             icon: Icon(Icons.settings,size: 24,),
             onTap: () {
               print("sddddddddddddd");
             },
           ),
           SizedBox(height: 30),
           ProfileOptionWidget(
             text: "Logout",
             color: Colors.red.shade100,
             icon: Icon(Icons.logout,size: 22),
             onTap: () {
               logoutDialog.showLogoutDialog(context);
             },
           ),
         ],
       ),
    );
  }
}
