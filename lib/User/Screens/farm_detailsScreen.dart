import 'dart:io';
import 'package:farm_booking_app/Common%20Widget/button_widget.dart';
import 'package:farm_booking_app/Routes/routes_name.dart';
import 'package:farm_booking_app/Utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FarmDetailsScreen extends StatefulWidget {

  final Map<String, dynamic> farmData;

  const FarmDetailsScreen({
    super.key,
    required this.farmData
  });

  @override
  State<FarmDetailsScreen> createState() => _FarmDetailsScreenState();
}

class _FarmDetailsScreenState extends State<FarmDetailsScreen> {

  bool loading = false;

  late String id, imageUrl ,farmName, price, description, city, location, room, bed, ownerName, ownerPhone;

  void isLogin(){

    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if(user != null){
      Get.toNamed(
        RoutesName.bookingScreen,
        arguments: {
          'id': id,
          'price': price,
          'imageUrl': imageUrl,
          'farmName': farmName
        },
      );
    }else{
      Utils().toastMessage("Please Login First !!");
      Get.toNamed(RoutesName.loginScreen);
    }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    id = widget.farmData['Id'];
    imageUrl = widget.farmData['ImageUrl'];
    farmName = widget.farmData['FarmName'];
    price = widget.farmData['Price'];
    description = widget.farmData['Description'];
    city = widget.farmData['City'];
    location = widget.farmData['Location'];
    room = widget.farmData['RoomNum'];
    bed = widget.farmData['BedType'];
    ownerName = widget.farmData['OwnerName'];
    ownerPhone = widget.farmData['OwnerPhone'];

    print("FARM : iiiiiiiiiiiiiiiiiiiiddddddddd : $id");

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green.shade300,
        title: Text("Farm",style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            fontFamily: "LocalFont",
            color: Colors.black,
            letterSpacing: 1.5
        ),),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: Get.width,
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  height: Get.height / 3.9,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 5,
                        spreadRadius: 2,
                      )
                    ],
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(5),
                    image: imageUrl.isNotEmpty ? DecorationImage(
                      image: FileImage(File(imageUrl)),
                      fit: BoxFit.cover,
                    ) : null,
                  )
              ),

              SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("$farmName",style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade900,
                      fontFamily: "LocalFont",
                      letterSpacing: 1
                  ),),
                  Text("₹ $price",style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade900,
                      fontFamily: "LocalFont",
                      letterSpacing: 1
                  ),)
                ],
              ),

              SizedBox(height: 20),
              Text('$description',style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade900,
                  fontFamily: "LocalFont",
                  letterSpacing: 1
              ),),

              SizedBox(height: 10),
              ListTile(
                leading: Icon(Icons.location_city),
                title: Text('$city',style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade900,
                    fontFamily: "LocalFont",
                    letterSpacing: 1
                ),),
              ),
              ListTile(
                leading: Icon(Icons.location_on),
                title: Text('$location',style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade900,
                    fontFamily: "LocalFont",
                    letterSpacing: 1
                ),),
              ),

              SizedBox(height: 10),
              Text('Facility : ',style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade900,
                  fontFamily: "LocalFont",
                  letterSpacing: 1
              ),),

              SizedBox(height: 10),
              ListTile(
                leading: Icon(Icons.meeting_room_sharp),
                title: Text('$room',style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade900,
                    fontFamily: "LocalFont",
                    letterSpacing: 1
                ),),
              ),
              ListTile(
                leading: Icon(Icons.bed),
                title: Text('$bed',style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade900,
                    fontFamily: "LocalFont",
                    letterSpacing: 1
                ),),
              ),

              SizedBox(height: 10),
              Text('Owner Contact : ',style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade900,
                  fontFamily: "LocalFont",
                  letterSpacing: 1
              ),),

              SizedBox(height: 10),
              ListTile(
                leading: Icon(Icons.person),
                title: Text('$ownerName',style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade900,
                    fontFamily: "LocalFont",
                    letterSpacing: 1
                ),),
              ),
              ListTile(
                leading: Icon(Icons.phone),
                title: Text('$ownerPhone',style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade900,
                    fontFamily: "LocalFont",
                    letterSpacing: 1
                ),),
              ),

              SizedBox(height: 15),
              Center(
                child: ButtonWidget(
                    text: "Click To Proceed",
                    width: 1.2,
                    onTap: () {
                      isLogin();
                    },
                    loading: loading,
                    backColor: Colors.green,
                    txtColor: Colors.white
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}

