import 'package:farm_booking_app/Admin/Widget/admin_profile_imageWidget.dart';
import 'package:farm_booking_app/Common%20Widget/logout_dialog.dart';
import 'package:farm_booking_app/Routes/routes_name.dart';
import 'package:farm_booking_app/Utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Common Widget/profile_option_widget.dart';

class AdminProfileScreen extends StatefulWidget {
  const AdminProfileScreen({super.key});

  @override
  State<AdminProfileScreen> createState() => _AdminProfileScreenState();
}

class _AdminProfileScreenState extends State<AdminProfileScreen> {

  final auth = FirebaseAuth.instance;
  LogoutDialog logoutDialog = LogoutDialog();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            SizedBox(height: 10),

            AdminProfileImageWidget(),

            SizedBox(height: 100),

            ProfileOptionWidget(
              text: "Add Farms",
              color: Colors.green.shade100,
              icon: Icon(Icons.add_box,size: 22),
              onTap: () {
                Get.toNamed(RoutesName.addFarmScreen);
              },
            ),
            SizedBox(height: 30),

            ProfileOptionWidget(
              text: "History",
              color: Colors.green.shade100,
              icon: Icon(Icons.list,size: 22),
              onTap: () {
                Get.toNamed(RoutesName.bookedFarmHistory);
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
                        print("Logout sssssssssssssssssssssssssssssssssss");
                      Get.offAllNamed(RoutesName.navbarWidget.toString());
                    })
                        .onError((error, stackTrace) {
                      Utils().toastMessage("Something Went Wrong, Please Try Again");
                    });
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
