import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green.shade300,
        title: Text("Favorites",style: TextStyle(
          fontSize: 35,
          fontWeight: FontWeight.bold,
          fontFamily: "LocalFont",
          color: Colors.black,
          letterSpacing: 1.5
        ),),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // SizedBox(height: 70),
            // Center(
            //   child: Text("Favorites",style: TextStyle(
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
                    height: Get.height / 2.5
                  );
                }
            )
          ],
        ),
      ),
    );
  }
}
