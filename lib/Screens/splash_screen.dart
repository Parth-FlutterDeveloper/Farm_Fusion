import 'dart:async';
import 'package:farm_booking_app/Routes/routes_name.dart';
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

    Timer(Duration(seconds: 2), (){
      Get.offNamed(RoutesName.navbarWidget.toString());
    });
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
            child: Text("Find peace between nature.\nBook your farmhouse today.",
            style: TextStyle(
              color: Colors.green.shade900,
              fontFamily: 'SplashFont',
              fontSize: 16.5,
              fontWeight: FontWeight.bold
            ),),
          ),

        ],
      ),
    );
  }
}
