import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Column(
         children: [
           SizedBox(height: 50),
           Center(
             child: Text("User Profile",style: TextStyle(
                 fontSize: 33,
                 fontWeight: FontWeight.bold,
                 fontFamily: "LocalFont",
                 color: Colors.green
             ),),
           ),
         ],
       ),
    );
  }
}
