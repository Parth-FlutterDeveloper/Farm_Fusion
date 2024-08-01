
import 'package:farm_booking_app/Routes/routes_name.dart';
import 'package:farm_booking_app/Screens/register_screen.dart';
import 'package:farm_booking_app/Screens/splash_screen.dart';
import 'package:farm_booking_app/Widgets/Login%20&%20Register%20Widget/verify_code.dart';
import 'package:farm_booking_app/Widgets/Navbar%20Widget/navbar_widget.dart';
import 'package:get/get.dart';
import '../Screens/login_screen.dart';
import '../Widgets/Login & Register Widget/forgot_password.dart';

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
    )

  ];

}