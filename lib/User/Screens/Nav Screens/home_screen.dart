import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Widgets/Home Widget/farm_listWidget.dart';
import '../../Widgets/Home Widget/offer_template_widget.dart';

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
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green.shade300,
        title: Text("Farm Fusion",style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            fontFamily: "LocalFont",
            color: Colors.black,
            letterSpacing: 1.5
        ),),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            OfferTemplateWidget(),
            SizedBox(height: 17),

            FarmListWidget(),

            Container(
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 35),
              height: Get.height / 7.4,
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(11),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        blurRadius: 1,
                        spreadRadius: 1
                    )
                  ]
              ),
              child: Center(child: Text('A farm booking app simplifies scheduling '
                  '\n       visits, managing reservations, and '
                  '\n    enhancing farm experiences with easy '
                  '\n               access to available slots.',style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade900,
                  fontFamily: "LocalFont",
                  letterSpacing: 1
              ))),
            ),
          ],
        ),
      ),
    );
  }
}
