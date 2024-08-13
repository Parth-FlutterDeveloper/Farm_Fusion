import 'package:farm_booking_app/Admin/Screens/admin_homeScreen.dart';
import 'package:farm_booking_app/Admin/Screens/admin_profileScreen.dart';
import 'package:farm_booking_app/Routes/routes_name.dart';
import 'package:get/get.dart';
import '../Admin/Widget/admin_navbarWidget.dart';
import '../User/Screens/login_screen.dart';
import '../User/Screens/register_screen.dart';
import '../User/Screens/splash_screen.dart';
import '../User/Widgets/Login & Register Widget/forgot_password.dart';
import '../User/Widgets/Login & Register Widget/verify_code.dart';
import '../User/Widgets/Navbar Widget/navbar_widget.dart';

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
    ),

    GetPage(
      name: RoutesName.loginScreen,
      page: () => LoginScreen(),
      transitionDuration: Duration(milliseconds: 250),
      transition: Transition.rightToLeftWithFade,
    ),

    GetPage(
      name: RoutesName.registerScreen,
      page: () => RegisterScreen(),
      transitionDuration: Duration(milliseconds: 250),
      transition: Transition.rightToLeftWithFade,
    ),

    GetPage(
      name: RoutesName.forgotPassword,
      page: () => ForgotPassword(),
      transitionDuration: Duration(milliseconds: 250),
      transition: Transition.rightToLeftWithFade,
    ),

    GetPage(
      name: RoutesName.codeVerification,
      page: () {
        final String verificationId = Get.arguments;
        return CodeVerification(verificationId: verificationId);
      },
      transitionDuration: Duration(milliseconds: 250),
      transition: Transition.rightToLeftWithFade,
    ),

    GetPage(
      name: RoutesName.adminNavbarWidget,
      page: () => AdminNavbarWidget(),
      transitionDuration: Duration(milliseconds: 250),
      transition: Transition.rightToLeftWithFade,
    ),

    GetPage(
      name: RoutesName.adminHomeScreen,
      page: () => AdminHomeScreen(),
      transitionDuration: Duration(milliseconds: 250),
      transition: Transition.rightToLeftWithFade,
    ),

    GetPage(
      name: RoutesName.adminProfileScreen,
      page: () => AdminProfileScreen(),
      transitionDuration: Duration(milliseconds: 250),
      transition: Transition.rightToLeftWithFade,
    ),

  ];

}