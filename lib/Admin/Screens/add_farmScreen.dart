import 'dart:io';
import 'package:farm_booking_app/Common%20Widget/button_widget.dart';
import 'package:farm_booking_app/Utils/utils.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../Routes/routes_name.dart';
import '../../Services/database.dart';
import '../Widget/Add Farm Widget/admin_customTextField.dart';
import '../Widget/Add Farm Widget/custom_radioWidget.dart';

class AddFarmScreen extends StatefulWidget {
  const AddFarmScreen({super.key});

  @override
  State<AddFarmScreen> createState() => _AddFarmScreenState();
}

class _AddFarmScreenState extends State<AddFarmScreen> {

  int _selectedRoom = 1;
  int _selectedBed = 1;
  bool loading = false;
  var indiaPin = "+91 ";
  final _formKey = GlobalKey<FormState>();

  TextEditingController farmNameController = TextEditingController();
  TextEditingController farmDescriptionController = TextEditingController();
  TextEditingController farmPriceController = TextEditingController();
  TextEditingController farmCityController = TextEditingController();
  TextEditingController farmLocationController = TextEditingController();
  TextEditingController farmOwnerNameController = TextEditingController();
  TextEditingController farmOwnerPhoneController = TextEditingController();

  Map<int, String> roomOptions = {
    1: "One Room",
    2: "Two Rooms",
    3: "Three Rooms",
  };
  late String selectedRoomText;
  Map<int, String> bedOptions = {
    1: "Single Bed",
    2: "Double Bed",
  };
  late String selectedBedText;


  // To Add Image and Image Url into the Collection

  String? profileImageUrl;
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  // Pick an image from the gallery
  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
      uploadImageToFirebase();
    }
  }

  // Upload the selected image to Firebase and save URL
  Future<void> uploadImageToFirebase() async {
    if (_imageFile == null) return;
    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('farmImages/${DateTime.now().millisecondsSinceEpoch}.png');
      // Upload file
      final uploadTask = storageRef.putFile(_imageFile!);
      // download URL
      final snapshot = await uploadTask;
      profileImageUrl = await snapshot.ref.getDownloadURL();
      setState(() {});
    } catch (e) {
      print("Error uploading image: $e");
    }
  }
  //---------------------------


  // Add Farm Details into Firebase Firestore
  DatabaseMethod dbMethod = DatabaseMethod();
  Future<void> _addFarm() async {
    setState(() {
      loading = true;
    });
    if (_formKey.currentState!.validate()) {
      String id = DateTime.now().millisecondsSinceEpoch.toString();
      Map<String, dynamic> farmInfoMap = {
        "Id": id,
        "ImageUrl": profileImageUrl,
        "FarmName": farmNameController.text,
        "Description": farmDescriptionController.text,
        "Price": farmPriceController.text,
        "City": farmCityController.text,
        "Location": farmLocationController.text,
        "RoomNum": selectedRoomText,
        "BedType": selectedBedText,
        "OwnerName": farmOwnerNameController.text,
        "OwnerPhone": indiaPin + farmOwnerPhoneController.text
      };
      await dbMethod.addFarmDetails(farmInfoMap, id);
      Utils().toastMessage("Farm Added Successfully");
      setState(() {
        loading = false;
      });
      Get.offNamed(RoutesName.adminNavbarWidget);
    }else{
      Utils().redToastMessage("Please enter all details !!");
      setState(() {
        loading = false;
      });
    }
  }
  // ----------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade400,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 13, right: 13, top: 60, bottom: 13),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(21.0),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 11,right: 11,top: 20,bottom: 10),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                              icon: Icon(Icons.arrow_back),
                              onPressed: () {
                                Get.back();
                              },
                          ),
                          SizedBox(width: 58,),
                          Text('Add Farm', style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.green.shade700,
                              fontFamily: "LocalFont",
                              letterSpacing: 2
                          ),),
                        ],
                      ),
                      SizedBox(height: 35),


                      Padding(
                        padding: EdgeInsets.only(left: 2.0, bottom: 15),
                        child: Row(
                          children: [
                            SizedBox(width: 2),
                            Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.green.shade700
                              ),
                            ),
                            SizedBox(width: 10),
                            Text("Add Farm Image",style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontFamily: "LocalFont",
                                letterSpacing: 1
                            ),)
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          await pickImage();
                        },
                        child: Container(
                          width: Get.width / 1.2,
                          height: Get.height / 3.8,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(11),
                            image: profileImageUrl != null
                                ? DecorationImage(
                              image: NetworkImage(profileImageUrl!),
                              fit: BoxFit.cover,
                            )
                                : null,
                          ),
                          child: profileImageUrl == null
                              ? Icon(
                            Icons.add_a_photo,
                            color: Colors.white,
                            size: 50,
                          )
                              : null,
                        ),
                      ),


                      SizedBox(height: 21),
                      Divider(color: Colors.green, thickness: 2),
                      SizedBox(height: 23),


                      CustomTextFieldWidget(
                        controller: farmNameController,
                        label: "Enter Name",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Enter Name";
                          }
                          return null;
                        },
                      ),
                      CustomTextFieldWidget(
                        controller: farmDescriptionController,
                        label: "Enter Description",
                        maxLines: 3,
                        maxLength: 100,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Enter Description";
                          }
                          if (value.length <= 10){
                            return "More then 10 Character";
                          }
                          return null;
                        },
                      ),
                      CustomTextFieldWidget(
                        controller: farmPriceController,
                        label: "Enter Price",
                        keyboardType: TextInputType.number,
                        prefixIcon: Icon(Icons.currency_rupee, size: 20),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Enter Price";
                          }
                          return null;
                        },
                      ),
                      CustomTextFieldWidget(
                        controller: farmCityController,
                        label: "Enter City",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Enter City";
                          }
                          return null;
                        },
                      ),
                      CustomTextFieldWidget(
                        controller: farmLocationController,
                        label: "Enter Location",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Enter Location";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 21),


                      Padding(
                        padding: EdgeInsets.only(left: 2.0, bottom: 10),
                        child: Row(
                          children: [
                            SizedBox(width: 2),
                            Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.green.shade700
                              ),
                            ),
                            SizedBox(width: 10),
                            Text("Enter Room Number :",style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontFamily: "LocalFont",
                                letterSpacing: 1
                            ),)
                          ],
                        ),
                      ),
                      RoomRadioButtonWidget(
                          value: 1,
                          text: "One Room",
                          groupValue: _selectedRoom,
                          onChanged: (int? value) {
                            setState(() {
                              _selectedRoom = value!;
                              selectedRoomText = roomOptions[_selectedRoom]!;
                            });
                          }
                      ),
                      RoomRadioButtonWidget(
                          value: 2,
                          text: "Two Rooms",
                          groupValue: _selectedRoom,
                          onChanged: (int? value) {
                            setState(() {
                              _selectedRoom = value!;
                              selectedRoomText = roomOptions[_selectedRoom]!;
                            });
                          }
                      ),
                      RoomRadioButtonWidget(
                          value: 3,
                          text: "Three Rooms",
                          groupValue: _selectedRoom,
                          onChanged: (int? value) {
                            setState(() {
                              _selectedRoom = value!;
                              selectedRoomText = roomOptions[_selectedRoom]!;
                            });
                          }
                      ),
                      SizedBox(height: 15),


                      Padding(
                        padding: EdgeInsets.only(left: 2.0, bottom: 10),
                        child: Row(
                          children: [
                            SizedBox(width: 2),
                            Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.green.shade700
                              ),
                            ),
                            SizedBox(width: 10),
                            Text("Enter Bed Style :",style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontFamily: "LocalFont",
                                letterSpacing: 1
                            ),)
                          ],
                        ),
                      ),
                      RoomRadioButtonWidget(
                          value: 1,
                          text: "Single Bed",
                          groupValue: _selectedBed,
                          onChanged: (int? value) {
                            setState(() {
                              _selectedBed = value!;
                              selectedBedText = bedOptions[_selectedBed]!;
                            });
                          }
                      ),
                      RoomRadioButtonWidget(
                          value: 2,
                          text: "Double Bed",
                          groupValue: _selectedBed,
                          onChanged: (int? value) {
                            setState(() {
                              _selectedBed = value!;
                              selectedBedText = bedOptions[_selectedBed]!;
                            });
                          }
                      ),


                      SizedBox(height: 10),
                      Divider(color: Colors.green, thickness: 2),
                      SizedBox(height: 21),


                      CustomTextFieldWidget(
                        controller: farmOwnerNameController,
                        label: "Enter Your Name",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Enter Name";
                          }
                          return null;
                        },
                      ),
                      CustomTextFieldWidget(
                        controller: farmOwnerPhoneController,
                        label: "Enter Your Phone",
                        keyboardType: TextInputType.number,
                        prefixText: "+91 ",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Enter Phone";
                          }
                          if (value.length != 10) {
                            return "Enter Valid Number";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 8),


                      ButtonWidget(
                          text: "Add Farm",
                          width: 1.7,
                          onTap: () {
                            _addFarm();
                          },
                          loading: loading,
                          backColor: Colors.green,
                          txtColor: Colors.white
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
