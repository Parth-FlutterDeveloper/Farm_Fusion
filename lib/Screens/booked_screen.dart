import 'package:flutter/material.dart';

class BookedScreen extends StatefulWidget {
  const BookedScreen({super.key});

  @override
  State<BookedScreen> createState() => _BookedScreenState();
}

class _BookedScreenState extends State<BookedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 50),
          Center(
            child: Text("Booked Farm",style: TextStyle(
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
