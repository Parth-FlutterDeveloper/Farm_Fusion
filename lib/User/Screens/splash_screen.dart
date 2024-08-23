import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_booking_app/Routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Services/shared_preference.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  String? email;
  SharedPreferenceHelper spHelper = SharedPreferenceHelper();

  getDataFromSPHelper() async {
    email = await spHelper.getUserEmail();
    setState(() {
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataFromSPHelper();

    Timer(Duration(seconds: 3), () async {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("users")
          .where('Email', isEqualTo: email)
          .get();
      if (querySnapshot.docs.isNotEmpty){
        DocumentSnapshot userDoc = querySnapshot.docs.first;
        String fetchedRole = userDoc["Role"];
        if(fetchedRole == "admin"){
          Get.offNamed(RoutesName.adminNavbarWidget);
        }else{
          Get.offAllNamed(RoutesName.navbarWidget);
        }
      }else {
        Get.offNamed(RoutesName.navbarWidget.toString());
      }}
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade300,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              SizedBox(height: 190),
              Container(
                height: 200,
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26,
                          blurRadius: 8,
                          spreadRadius: 3
                      )
                    ]
                ),
                child: CircleAvatar(
                  radius: 162,
                  backgroundImage: AssetImage('assets/images/splashImage.jpeg'),
                ),
              ),
              SizedBox(height: 27),
              Container(
                  padding: EdgeInsets.only(top: 5),
                  width: 240,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26,
                            blurRadius: 8,
                            spreadRadius: 3
                        )
                      ]
                  ),
                  child: Center(
                    child: Text("Farm Fusion",style: TextStyle(
                        fontSize: 29,
                        color: Colors.green,
                        fontFamily: 'SplashFont',
                        fontWeight: FontWeight.bold
                    ),),
                  )
              ),
            ],
          ),

          SizedBox(height: 10),

          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              children: [
                CircularProgressIndicator(color: Colors.green.shade900,strokeWidth: 2),
                SizedBox(height: 30),
                Text("Find peace between nature.\nBook your farmhouse today.",
                style: TextStyle(
                  color: Colors.green.shade900,
                  fontFamily: 'SplashFont',
                  fontSize: 16.5,
                  fontWeight: FontWeight.bold
                ),),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
