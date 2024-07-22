import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileImageWidget extends StatefulWidget {
  const ProfileImageWidget({super.key});

  @override
  State<ProfileImageWidget> createState() => _ProfileImageWidgetState();
}

class _ProfileImageWidgetState extends State<ProfileImageWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: Get.height / 7,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black26
          ),
        ),
        SizedBox(height: 20),
        Text("Name",style: TextStyle(
          fontSize: 19,
          fontFamily: 'LocalFont',
          fontWeight: FontWeight.bold,
          letterSpacing: 1
        ),),
        Text("Email",style: TextStyle(
            fontSize: 17,
            fontFamily: 'LocalFont',
            fontWeight: FontWeight.bold,
            letterSpacing: 1
        ),)
      ],
    );
  }
}