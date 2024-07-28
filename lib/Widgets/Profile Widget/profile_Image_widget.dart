import 'package:flutter/material.dart';

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
        InkWell(
          onTap: () {
            print("sddddddddddddd");
          },
          child: Container(
            height: 135,
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      spreadRadius: 3
                  )
                ]
            ),
            child: CircleAvatar(
              radius: 110,
              backgroundImage: AssetImage('assets/images/splashImage.jpeg'),
            ),
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
