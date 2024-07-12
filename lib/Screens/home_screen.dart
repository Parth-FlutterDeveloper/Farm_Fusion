import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Farm Fusion",style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            fontFamily: "LocalFont",
            color: Colors.white,
            letterSpacing: 1
        ),),
      ),
    );
  }
}
