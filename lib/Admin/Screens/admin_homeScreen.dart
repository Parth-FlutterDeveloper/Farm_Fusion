import 'package:farm_booking_app/Admin/Widget/farm_listWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Services/shared_preference.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {

  String? name;
  SharedPreferenceHelper spHelper = SharedPreferenceHelper();

  getDataFromSPHelper() async {
    name = await spHelper.getUserName();
    setState(() {
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataFromSPHelper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 60),

            Center(
              child: Text("Welcome $name",style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontFamily: "LocalFont",
                  color: Colors.green,
                  letterSpacing: 1.5
              ),),
            ),

            Container(
              height: 57,
              width: Get.width,
              margin: EdgeInsets.only(right: 20.0,left: 20.0,top: 40),
              decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(11)
              ),
              child: Center(),
            ),

            SizedBox(height: 10),

            FarmListWidget()

          ],
        ),
      ),
    );
  }
}
