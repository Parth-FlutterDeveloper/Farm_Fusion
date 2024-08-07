import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Routes/routes_name.dart';
import '../../Utils/utils.dart';

class LogoutDialog {

  final auth = FirebaseAuth.instance;

  void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // backgroundColor: Colors.green.shade50,
          title: Text('Logout',style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            fontFamily: "LocalFont",
            color: Colors.green.shade900,
            letterSpacing: 1
          ),),
          content: Text('Are you sure you want to log out?',style: TextStyle(
            fontFamily: "LocalFont",
            fontSize: 18,
            fontWeight: FontWeight.bold,
            wordSpacing: 1
          ),),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                auth.signOut()
                    .then((value) {
                  Get.offAllNamed(RoutesName.navbarWidget.toString());
                })
                    .onError((error, stackTrace) {
                  Utils().toastMessage("Something Went Wrong, Please Try Again");
                });
              },
              child: Text('Logout',style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  fontFamily: "LocalFont",
                  color: Colors.red,
                  letterSpacing: 1,
              ),),
            ),
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text('Cancel',style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  fontFamily: "LocalFont",
                  color: Colors.green.shade900,
                  letterSpacing: 1
              ),),
            ),
          ],
        );
      },
    );
  }
}