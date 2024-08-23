import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_booking_app/Routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FarmListWidget extends StatefulWidget {
  const FarmListWidget({super.key});

  @override
  State<FarmListWidget> createState() => _FarmListWidgetState();
}

class _FarmListWidgetState extends State<FarmListWidget> {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('farms').snapshots(),
        builder: (context, snapshot) {

          if (snapshot.hasError) {
            return Center(child: Text("Something went wrong"));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(color: Colors.green));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text("No farms available"));
          }

          final data = snapshot.requireData.docs;
          return ListView.builder(
            itemCount: data.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {

              var farmData = data[index].data() as Map<String, dynamic>?;
              if (farmData == null) {
                return Center(child: Text("Error: Farm data unavailable")); // Handle null case
              }
              var imageUrl = farmData['ImageUrl'];
              var farmName = farmData['FarmName'];
              var description = farmData['Description'];
              var price = farmData['Price'];

                return Container(
                  margin: EdgeInsets.only(left: 20, right: 20, bottom: 25),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26,
                          blurRadius: 8,
                          spreadRadius: 3
                      )
                    ],
                    borderRadius: BorderRadius.circular(11),
                    color: Colors.green.shade50,
                  ),
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(
                          RoutesName.updateFarmScreen,
                          arguments: farmData,
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: Get.height / 3.9,
                          margin: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black,
                                blurRadius: 2,
                              )
                            ],
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(11),
                            image: imageUrl.isNotEmpty ? DecorationImage(
                              image: FileImage(File(imageUrl)),
                              fit: BoxFit.cover,
                            ) : null,
                          )
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 20, bottom: 4),
                              child: Text('$farmName',style: TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.yellow.shade900,
                                  fontFamily: "LocalFont",
                                  letterSpacing: 1
                              ),),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 20),
                              child: Text('₹ $price',style: TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.yellow.shade900,
                                  fontFamily: "LocalFont",
                                  letterSpacing: 1
                              ),),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5, left: 20, bottom: 15, right: 20),
                          child: Text('$description',style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.green.shade900,
                              fontFamily: "LocalFont",
                              letterSpacing: 1
                          ),),
                        ),
                      ],
                    ),
                  ),
                );
              },
          );
        }
    );
  }
}
