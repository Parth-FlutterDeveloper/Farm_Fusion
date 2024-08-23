import 'dart:io';
import 'package:farm_booking_app/Admin/Widget/delete_farmDialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../Common Widget/button_widget.dart';
import '../../Routes/routes_name.dart';
import '../../Services/database.dart';
import '../../Utils/utils.dart';
import '../Widget/Add Farm Widget/admin_customTextField.dart';
import '../Widget/Add Farm Widget/custom_radioWidget.dart';

class UpdateFarmScreen extends StatefulWidget {

  final Map<String, dynamic> farmData;

  const UpdateFarmScreen({
    super.key,
    required this.farmData
  });

  @override
  State<UpdateFarmScreen> createState() => _UpdateFarmScreenState();
}

class _UpdateFarmScreenState extends State<UpdateFarmScreen> {

  int _selectedRoom = 1;
  int _selectedBed = 1;
  bool loading = false;
  bool deleteLoading = false;
  final _formKey = GlobalKey<FormState>();
  DatabaseMethod dbMethod = DatabaseMethod();
  DeleteFarmDialog deleteFarmDialog = DeleteFarmDialog();


  late TextEditingController farmNameController;
  late TextEditingController farmDescriptionController;
  late TextEditingController farmPriceController;
  late TextEditingController farmCityController;
  late TextEditingController farmLocationController;
  late TextEditingController farmOwnerNameController;
  late TextEditingController farmOwnerPhoneController;


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


  // To Add Image and Image Url
  XFile? _pickedImage;
  final ImagePicker _picker = ImagePicker();
  String? _imageUrl;

  @override
  void initState() {
    super.initState();

    // Initializing TextEditingControllers in initState
    farmNameController = TextEditingController(text: widget.farmData['FarmName']);
    farmDescriptionController = TextEditingController(text: widget.farmData['Description']);
    farmPriceController = TextEditingController(text: widget.farmData['Price']);
    farmCityController = TextEditingController(text: widget.farmData['City']);
    farmLocationController = TextEditingController(text: widget.farmData['Location']);
    farmOwnerNameController = TextEditingController(text: widget.farmData['OwnerName']);
    farmOwnerPhoneController = TextEditingController(text: widget.farmData['OwnerPhone']);
    _selectedRoom = roomOptions.entries
        .firstWhere((entry) => entry.value == widget.farmData['RoomNum'])
        .key;
    _selectedBed = bedOptions.entries
        .firstWhere((entry) => entry.value == widget.farmData['BedType'])
        .key;
    selectedRoomText = roomOptions[_selectedRoom]!;
    selectedBedText = bedOptions[_selectedBed]!;
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      _imageUrl = image.path;
      setState(() {
        _pickedImage = image;
      });
    }
  }
  //---------------------------


  // Update Farm Details into Firebase Firestore
  Future<void> _updateFarm() async {
    setState(() {
      loading = true;
    });
    if (_formKey.currentState!.validate()) {
      String id = widget.farmData['Id'];
      Map<String, dynamic> farmInfoMap = {

        "Id": id,
        "ImageUrl": _imageUrl ?? widget.farmData['ImageUrl'],


      "FarmName": farmNameController.text.isEmpty
            ? widget.farmData['FarmName']
            : farmNameController.text,

        "Description": farmDescriptionController.text.isEmpty
            ? widget.farmData['Description']
            : farmDescriptionController.text,

        "Price": farmPriceController.text.isEmpty
            ? widget.farmData['Price']
            : farmPriceController.text,

        "City": farmCityController.text.isEmpty
            ? widget.farmData['City']
            : farmCityController.text,

        "Location": farmLocationController.text.isEmpty
            ? widget.farmData['Location']
            : farmLocationController.text,

        "RoomNum": selectedRoomText,
        "BedType": selectedBedText,

        "OwnerName": farmOwnerNameController.text.isEmpty
            ? widget.farmData['OwnerName']
            : farmOwnerNameController.text,

        "OwnerPhone": farmOwnerPhoneController.text.isEmpty
            ? widget.farmData['OwnerPhone']
            : farmOwnerPhoneController.text
      };
      await dbMethod.updateFarmDetails(farmInfoMap, id);
      Utils().toastMessage("Farm Updated Successfully");
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
  // -----------------------


  // ---------Delete Farm ---------
  Future<void> _deleteFarm() async {
    setState(() {
      deleteLoading = true;
    });
    try {
      String id = widget.farmData['Id'];
      await dbMethod.deleteFarm(id);
      Utils().toastMessage("Farm Deleted Successfully");
      Get.offNamed(RoutesName.adminNavbarWidget);
    } catch (e) {
      Utils().redToastMessage("Error deleting farm: $e");
    } finally {
      setState(() {
        deleteLoading = false;
      });
    }
  }
  //------------------------------


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 13, right: 13, top: 60, bottom: 13),
            child: Card(
              color: Colors.white,
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
                          SizedBox(width: 38,),
                          Text('Update Farm', style: TextStyle(
                              fontSize: 30,
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
                        onTap: _pickImage,
                        child: Container(
                          width: Get.width / 1.2,
                          height: Get.height / 3.8,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(11),
                            image: _pickedImage != null
                                ? DecorationImage(
                              image: FileImage(File(_pickedImage!.path)),
                              fit: BoxFit.cover,
                            )
                                : null,
                          ),
                          child: _pickedImage == null
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
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Enter Phone";
                          }
                          if (value.length != 14) {
                            return "Enter Valid Number OR +91";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 8),


                      ButtonWidget(
                          text: "Update Farm",
                          width: 1.7,
                          onTap: () {
                            _updateFarm();
                          },
                          loading: loading,
                          backColor: Colors.green,
                          txtColor: Colors.white
                      ),
                      SizedBox(height: 15),

                      ButtonWidget(
                          text: "Delete Farm",
                          width: 1.7,
                          onTap: () {
                            deleteFarmDialog.showDeleteDialog(
                              context,
                                  () { _deleteFarm(); },
                            );
                          },
                          loading: deleteLoading,
                          backColor: Colors.red.shade400,
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
