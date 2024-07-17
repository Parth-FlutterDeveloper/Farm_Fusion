import 'dart:async';
import 'package:farm_booking_app/Routes/routes_name.dart';
import 'package:farm_booking_app/Widgets/Splash%20Widgets/app_name_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(Duration(seconds: 4), (){
      Get.offNamed(RoutesName.navbarWidget.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              SizedBox(height: 160),
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
                  radius: 160,
                  backgroundImage: AssetImage('assets/images/splashImage.jpeg'),
                ),
              ),
              SizedBox(height: 27),
              AppNameWidget(),
            ],
          ),

          SizedBox(height: 10),

          Align(
            alignment: Alignment.bottomCenter,
            child: Text("Find peace between nature.\nBook your farmhouse today.",
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'SplashFont',
              fontSize: 16,
              fontWeight: FontWeight.bold
            ),),
          ),

        ],
      ),
    );
  }
}
