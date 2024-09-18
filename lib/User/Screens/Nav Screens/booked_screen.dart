import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Services/database.dart';
import '../../../Services/shared_preference.dart';
import '../../../Utils/utils.dart';

class BookedScreen extends StatefulWidget {
  const BookedScreen({super.key});

  @override
  State<BookedScreen> createState() => _BookedScreenState();
}

class _BookedScreenState extends State<BookedScreen> {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _searchController = TextEditingController();
  String searchQuery = "";
  String? userId;
  SharedPreferenceHelper spHelper = SharedPreferenceHelper();
  DatabaseMethod dbMethod = DatabaseMethod();
  late var auth;
  late var user;

  getDataFromSPHelper() async {
    userId = await spHelper.getUserId();
    setState(() {
      print("USER iiiiiiiiiiiiiiiiiiiiiiddddddddddddd : $userId");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataFromSPHelper();
    auth = FirebaseAuth.instance;
    user = auth.currentUser;
  }

  @override
  Widget build(BuildContext context) {

    if(user == null){
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.green.shade300,
          title: Text(
            "Booked Farm",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              fontFamily: "LocalFont",
              color: Colors.black,
              letterSpacing: 1.5,
            ),
          ),
        ),
        body: Center(
          child: Text(
            "Please login first !!"
                "\n  To Book a Farm",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: "LocalFont",
              color: Colors.red.shade900,
              letterSpacing: 1.5,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green.shade300,
        title: Text("Booked Farm",style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            fontFamily: "LocalFont",
            color: Colors.black,
            letterSpacing: 1.5
        ),),
      ),
      body: SingleChildScrollView(
        child: Column(
            children: [
              SizedBox(height: 30),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(11),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26,
                          blurRadius: 1,
                          spreadRadius: 1
                      )
                    ]
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value.toLowerCase();
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "Search Farms...",
                    hintStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: "LocalFont",
                        color: Colors.black54,
                        letterSpacing: 1.5
                    ),
                    prefixIcon: Icon(
                        Icons.search,
                        color: Colors.black
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
        
              SizedBox(height: 30),
              StreamBuilder<QuerySnapshot>(
                  stream: _firestore.collection('booking').snapshots(),
                  builder: (context, snapshot) {
        
                    if (snapshot.hasError) {
                      return Center(child: Text("Something went wrong"));
                    }
        
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator(color: Colors.green));
                    }
        
                    final data = snapshot.requireData.docs.where((doc) {
                      final bookingData = doc.data() as Map<String, dynamic>;
                      final farmName = bookingData['FarmName']?.toString().toLowerCase() ?? '';
                      return farmName.contains(searchQuery) && bookingData['UserId'] == userId;
                    }).toList();
        
                    if (data.isEmpty) {
                      return SizedBox(
                          height: 200,
                          child: const Center(
                              child: Text("No booked farms available !!!",style: TextStyle(fontSize: 16),)
                          )
                      );
                    }
        
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Center(child: Text("No farms available"));
                    }
        
                    return ListView.builder(
                      itemCount: data.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
        
                        var bookingData = data[index].data() as Map<String, dynamic>?;
                        if (bookingData == null) {
                          return Center(child: Text("Error: Farm data unavailable")); // Handle null case
                        }
                        var id = bookingData['Id'];
                        var imageUrl = bookingData['FarmImageUrl'];
                        var farmName = bookingData['FarmName'];
                        var date = bookingData['Date'];
                        var totalDays = bookingData['NumOfDays'];
                        var totalPrice = bookingData['TotalPrice'];

                        return Container(
                          margin: EdgeInsets.only(left: 20, right: 20, bottom: 30),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 1,
                                  spreadRadius: 1
                              )
                            ],
                            borderRadius: BorderRadius.circular(11),
                            color: Colors.green.shade50,
                          ),
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
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.yellow.shade900,
                                        fontFamily: "LocalFont",
                                        letterSpacing: 1
                                    ),),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 20),
                                    child: Text('₹ $totalPrice',style: TextStyle(
                                        fontSize: 21,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.yellow.shade900,
                                        fontFamily: "LocalFont",
                                        letterSpacing: 1
                                    ),),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 5, left: 20, bottom: 15, right: 20),
                                    child: Text('Date : $date'
                                        '\nBooked for $totalDays days',style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green.shade900,
                                        fontFamily: "LocalFont",
                                        letterSpacing: 1
                                    ),),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 20),
                                    child: IconButton(
                                      onPressed: () async {
                                        try {
                                          await dbMethod.deleteBookedFarm(id);
                                          Utils().toastMessage("Cancel Booking");
                                        } catch (e) {
                                          Utils().redToastMessage("Error deleting farm: $e");
                                        }
                                      },
                                      icon: Icon(Icons.delete,size: 25,color: Colors.black,),
                                    )
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
              )
            ]
        ),
      )
    );
  }
}
