
import 'package:farm_booking_app/Routes/routes_name.dart';
import 'package:farm_booking_app/Screens/App%20Screen/home_screen.dart';
import 'package:farm_booking_app/Screens/splash_screen.dart';
import 'package:farm_booking_app/Widgets/Navbar%20Widget/navbar_widget.dart';
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
      name: RoutesName.navbarWidget,
      page: () => NavbarWidget(),
      transitionDuration: Duration(milliseconds: 250),
      transition: Transition.rightToLeftWithFade,
    )

  ];

}