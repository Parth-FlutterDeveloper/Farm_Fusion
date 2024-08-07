
// Profile Screen for UnLogged Users.

import 'package:farm_booking_app/Routes/routes_name.dart';
import 'package:farm_booking_app/Widgets/Common%20Widget/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ULProfileScreen extends StatefulWidget {
  const ULProfileScreen({super.key});

  @override
  State<ULProfileScreen> createState() => _ULProfileScreenState();
}

class _ULProfileScreenState extends State<ULProfileScreen> {

  bool load = false;

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
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [

              SizedBox(height: 75),

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
              SizedBox(height: 20),
              Text("Farm Fusion",style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32,
                fontFamily: "SplashFont",
                letterSpacing: 2,
                color: Colors.green.shade800
              ),),

              SizedBox(height: 60),

              ButtonWidget(
                  width: 1.7,
                  loading: load,
                  txtColor: Colors.black,
                  backColor: Colors.green.shade200,
                  text: "Login",
                  onTap: () {
                    load = true;
                    Get.toNamed(RoutesName.loginScreen.toString())!
                        .then((value) {
                          setState(() {
                            load = false;
                          });
                    });
                  }
              ),
              SizedBox(height: 20),
              ButtonWidget(
                  width: 1.7,
                  loading: load,
                  txtColor: Colors.black,
                  backColor: Colors.green.shade200,
                  text: "Register",
                  onTap: () {
                    load = true;
                    Get.toNamed(RoutesName.registerScreen.toString())!
                        .then((value) {
                      setState(() {
                        load = false;
                      });
                    });
                  }
              ),

              SizedBox(height: 40),

              Text("If you think to book any Farm,\n"
                  "    Then first you go for the\n"
                  "           Register or Login",style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                fontFamily: "LocalFont",
                letterSpacing: 1,
              ),),
            ],
          ),
        ),
      ),
    );
  }
}
