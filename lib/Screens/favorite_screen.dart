import 'package:flutter/material.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 50),
          Center(
            child: Text("Favorites",style: TextStyle(
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
