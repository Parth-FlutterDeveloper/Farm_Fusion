import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green.shade300,
        title: Text("Favourites",style: TextStyle(
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
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(11),
                      color: Colors.black26,
                    ),
                    width: Get.width,
                    height: Get.height / 3.2
                  );
                }
            )
          ],
        ),
      ),
    );
  }
}
