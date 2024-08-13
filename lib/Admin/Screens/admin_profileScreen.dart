import 'package:farm_booking_app/Admin/Widget/admin_profile_imageWidget.dart';
import 'package:farm_booking_app/Common%20Widget/logout_dialog.dart';
import 'package:farm_booking_app/Routes/routes_name.dart';
import 'package:farm_booking_app/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Common Widget/profile_option_widget.dart';

class AdminProfileScreen extends StatefulWidget {
  const AdminProfileScreen({super.key});

  @override
  State<AdminProfileScreen> createState() => _AdminProfileScreenState();
}

class _AdminProfileScreenState extends State<AdminProfileScreen> {

  LogoutDialog logoutDialog = LogoutDialog();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            AdminProfileImageWidget(),

            SizedBox(height: 50),

            ProfileOptionWidget(
              text: "Add Farms",
              color: Colors.green.shade100,
              icon: Icon(Icons.add_box,size: 22),
              onTap: () {
                print("sddddddddddddd");
              },
            ),
            SizedBox(height: 30),

            ProfileOptionWidget(
              text: "See Booked Farms",
              color: Colors.green.shade100,
              icon: Icon(Icons.bookmark_added_rounded,size: 22),
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
                logoutDialog.showLogoutDialog(
                  context,
                  () {
                    Utils().toastMessage("In Progress !!");
                    Future.delayed(const Duration(seconds: 2),() {
                      Get.offNamed(RoutesName.navbarWidget);
                    });
                  },
                );
              },
            ),
            SizedBox(height: 30),

            Text("     You are a Admin here So,\n"
                "You have authority to managed \n"
                "     Farms in the application",style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              fontFamily: "LocalFont",
              letterSpacing: 1,
            ),),
          ],
        ),
      ),
    );
  }
}
