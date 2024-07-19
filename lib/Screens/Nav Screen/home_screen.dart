import 'package:farm_booking_app/Widgets/Home%20Widget/offer_template_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
              child: Text("Farm Fusion",style: TextStyle(
                fontSize: 33,
                fontWeight: FontWeight.bold,
                fontFamily: "LocalFont",
                color: Colors.green,
                letterSpacing: 1.5
              ),),
            ),
            SizedBox(height: 10),
            OfferTemplateWidget(),
            Container(
              height: 57,
              width: Get.width,
              margin: EdgeInsets.only(right: 20.0,left: 20.0,top: 27),
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(11)
              ),
              child: Center(
                // child: Text('Search'),
              ),
            ),
            ListView.builder(
                itemCount: 2,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                      margin: EdgeInsets.only(left: 20,right: 20,bottom: 20),
                      width: Get.width,
                      color: Colors.black26,
                      height: Get.height / 2.5,
                      // child: Center(child: Text('List of Farm')),
                  );
                }
            ),
            OfferTemplateWidget(),
            Container(
              margin: EdgeInsets.all(20),
              height: Get.height / 4.2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(11),
                color: Colors.black26
              ),
              // child: Center(child: Text('About App')),
            ),
          ],
        ),
      ),
    );
  }
}
