import 'package:farm_booking_app/Routes/routes.dart';
import 'package:farm_booking_app/Screens/splash_screen.dart';
import 'package:farm_booking_app/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const FarmFusion());
}

class FarmFusion extends StatefulWidget {
  const FarmFusion({super.key});

  @override
  State<FarmFusion> createState() => _FarmFusionState();
}

class _FarmFusionState extends State<FarmFusion> {

final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {

          if(snapshot.hasError){
            Utils().toastMessage("Something Went Wrong");
          }

          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(color: Colors.green,),);
          }

          if(snapshot.connectionState == ConnectionState.done){
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              home: SplashScreen(),
              getPages: AppRoutes.appRoutes(),
            );
          }

          return Center(child: CircularProgressIndicator(color: Colors.green,),);

        }
    );
  }
}
