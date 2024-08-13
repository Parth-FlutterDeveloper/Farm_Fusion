import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../../Screens/Nav Screens/booked_screen.dart';
import '../../Screens/Nav Screens/favourite_screen.dart';
import '../../Screens/Nav Screens/home_screen.dart';
import '../../Screens/Nav Screens/l_profile_screen.dart';
import '../../Screens/Nav Screens/ul_profile_screen.dart';


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