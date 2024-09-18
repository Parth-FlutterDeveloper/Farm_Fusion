import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../Services/shared_preference.dart';

class ProfileImageWidget extends StatefulWidget {
  const ProfileImageWidget({super.key});

  @override
  State<ProfileImageWidget> createState() => _ProfileImageWidgetState();
}

class _ProfileImageWidgetState extends State<ProfileImageWidget> {
  String? name, email;
  SharedPreferenceHelper spHelper = SharedPreferenceHelper();

  String? profileImageUrl;
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    getDataFromSPHelper();
  }

  getDataFromSPHelper() async {
    name = await spHelper.getUserName();
    email = await spHelper.getUserEmail();
    profileImageUrl = await spHelper.getUserProfileImage(); // Load the image URL
    setState(() {});
  }

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
      uploadImageToFirebase();
    }
  }

  Future<void> uploadImageToFirebase() async {
    if (_imageFile == null) return;
    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('userProfileImages/${DateTime.now().millisecondsSinceEpoch}.png');
      // Upload the file
      final uploadTask = storageRef.putFile(_imageFile!);
      // download url
      final snapshot = await uploadTask;
      profileImageUrl = await snapshot.ref.getDownloadURL();
      // Save imageUrl in Shared Preferences
      await spHelper.saveUserProfileImage(profileImageUrl!);
      setState(() {});
    } catch (e) {
      print("Error uploading image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: pickImage,
          child: Container(
            height: 160,
            width: 160,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                  spreadRadius: 3,
                )
              ],
            ),
            child: CircleAvatar(
              backgroundColor: Colors.green.shade100,
              foregroundImage: profileImageUrl != null
                  ? NetworkImage(profileImageUrl!) // Load image from Firebase URL
                  : null,
              child: profileImageUrl == null
                  ? Icon(Icons.person, size: 80, color: Colors.grey) // Default icon if no image
                  : null,
            ),
          ),
        ),
        SizedBox(height: 20),
        Text(
          name == null ? "Name" : "$name",
          style: TextStyle(
              fontSize: 22,
              fontFamily: 'LocalFont',
              fontWeight: FontWeight.bold,
              letterSpacing: 1),
        ),
        Text(
          email == null ? "Email" : "$email",
          style: TextStyle(
              fontSize: 16,
              fontFamily: 'LocalFont',
              fontWeight: FontWeight.bold,
              letterSpacing: 1),
        )
      ],
    );
  }
}
