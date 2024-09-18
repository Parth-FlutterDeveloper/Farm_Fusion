
// Profile Screen for Logged in Users.

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Common Widget/logout_dialog.dart';
import '../../../Routes/routes_name.dart';
import '../../../Utils/utils.dart';
import '../../Widgets/Logged Profile Widget/profile_Image_widget.dart';
import '../../../Common Widget/profile_option_widget.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  final auth = FirebaseAuth.instance;
  LogoutDialog logoutDialog = LogoutDialog();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green.shade300,
        title: Text("Profile",style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            fontFamily: "LocalFont",
            color: Colors.black,
            letterSpacing: 1.5
        ),),
      ),
       body: Column(
         children:  [

           SizedBox(height: 130),
           ProfileImageWidget(),
           SizedBox(height: 80),

           // ProfileOptionWidget(
           //   text: "Search Farms",
           //   color: Colors.green.shade100,
           //   icon: Icon(Icons.search,size: 22),
           //   onTap: () {},
           // ),
           // SizedBox(height: 30),

           ProfileOptionWidget(
             text: "Booked Farm",
             color: Colors.green.shade100,
             icon: Icon(Icons.book,size: 22),
             onTap: () {
               Get.toNamed(RoutesName.bookedFarmScreen);
             },
           ),
           SizedBox(height: 30),

           ProfileOptionWidget(
             text: "Logout",
             color: Colors.red.shade100,
             icon: Icon(Icons.logout,size: 22),
             onTap: () {
               logoutDialog.showLogoutDialog(
                  context,
                  () {
                      auth.signOut()
                      .then((value) {
                          Get.offAllNamed(RoutesName.navbarWidget.toString());
                      })
                      .onError((error, stackTrace) {
                          Utils().toastMessage("Something Went Wrong, Please Try Again");
                      });
                  },
               );
             },
           ),

           // SizedBox(height: 20),
           // Container(
           //   margin: EdgeInsets.only(top: 10, left: 40, right: 40, bottom: 25),
           //   height: Get.height / 7,
           //   decoration: BoxDecoration(
           //     color: Colors.green.shade50,
           //     borderRadius: BorderRadius.circular(11),
           //   ),
           //   child: Center(child: Text('',style: TextStyle(
           //       fontSize: 18,
           //       fontWeight: FontWeight.bold,
           //       color: Colors.green.shade900,
           //       fontFamily: "LocalFont",
           //       letterSpacing: 1
           //   ))),
           // ),
         ],
       ),
    );
  }
}
