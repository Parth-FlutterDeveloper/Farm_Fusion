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
      body: Column(
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
          Container(
            height: Get.height / 4.2,
            width: Get.width,
            margin: EdgeInsets.all(18),
            child: ListView.builder(
                itemCount: 4,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index){
                  return Card(
                    color: Colors.black12,
                    child: Container(
                      width: Get.width / 1.22,
                      // child: Center(child: Text('Offers')),
                    )
                  );
                }
            ),
          ),
          Container(
            height: 57,
            width: Get.width,
            margin: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(11)
            ),
            child: Center(
              // child: Text('Search'),
            ),
          ),
        ],
      ),
    );
  }
}
