
import 'package:farm_booking_app/Routes/routes_name.dart';
import 'package:farm_booking_app/Screens/home_screen.dart';
import 'package:farm_booking_app/Screens/splash_screen.dart';
import 'package:get/get.dart';

class AppRoutes{

  static appRoutes() => [

    GetPage(
        name: RoutesName.splashScreen,
        page: () => SplashScreen(),
        transitionDuration: Duration(milliseconds: 250),
        transition: Transition.rightToLeftWithFade,
    ),

    GetPage(
      name: RoutesName.homeScreen,
      page: () => HomeScreen(),
      transitionDuration: Duration(milliseconds: 250),
      transition: Transition.rightToLeftWithFade,
    )

  ];

}