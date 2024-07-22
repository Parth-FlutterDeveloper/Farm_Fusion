import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookedScreen extends StatefulWidget {
  const BookedScreen({super.key});

  @override
  State<BookedScreen> createState() => _BookedScreenState();
}

class _BookedScreenState extends State<BookedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green.shade300,
        title: Text("Booked Farm",style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            fontFamily: "LocalFont",
            color: Colors.black,
            letterSpacing: 1.5
        ),),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // SizedBox(height: 50),
            // Center(
            //   child: Text("Booked Farm",style: TextStyle(
            //       fontSize: 33,
            //       fontWeight: FontWeight.bold,
            //       fontFamily: "LocalFont",
            //       color: Colors.green
            //   ),),
            // ),
            SizedBox(height: 20),
            ListView.builder(
                itemCount: 5,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                      margin: EdgeInsets.only(left: 20,right: 20,bottom: 20),
                      width: Get.width,
                      color: Colors.black26,
                      height: Get.height / 3.0
                  );
                }
            )
          ],
        ),
      ),
    );
  }
}
