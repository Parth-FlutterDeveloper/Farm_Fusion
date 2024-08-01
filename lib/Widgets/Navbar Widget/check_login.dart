import 'package:farm_booking_app/Screens/Nav%20Screens/l_profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:farm_booking_app/Screens/Nav%20Screens/booked_screen.dart';
import 'package:farm_booking_app/Screens/Nav%20Screens/favourite_screen.dart';
import 'package:farm_booking_app/Screens/Nav%20Screens/home_screen.dart';
import 'package:farm_booking_app/Screens/Nav%20Screens/ul_profile_screen.dart';

class CheckLoginProcess {

  List<StatefulWidget> isLogin(BuildContext context){

    final auth = FirebaseAuth.instance;

    final user = auth.currentUser;

    if(user != null){
      final screens = [
        HomeScreen(),
        FavouriteScreen(),
        BookedScreen(),
        ProfileScreen()
      ];
      return screens;
    }

    else{
      final screens = [
        HomeScreen(),
        FavouriteScreen(),
        BookedScreen(),
        ULProfileScreen()
      ];
      return screens;
    }

  }

}