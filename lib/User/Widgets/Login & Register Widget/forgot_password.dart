import 'package:farm_booking_app/Routes/routes_name.dart';
import 'package:farm_booking_app/Utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Common Widget/button_widget.dart';
import '../../../Common Widget/custom_text_field.dart';


class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  final TextEditingController _emailController = TextEditingController();

  bool loading = false;

  forgetPass(String email){
    setState(() {
      loading = true;
    });
    FirebaseAuth.instance.sendPasswordResetEmail(email: email)
    .then((value) {
      Utils().toastMessage("Link sent to your Gmail");
      Get.offNamed(RoutesName.loginScreen.toString());
      setState(() {
        loading = false;
      });
    })
    .onError((error, stackTrace) {
      Utils().toastMessage("Enter Valid Email ID");
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade400,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(21.0),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 11,right: 11,top: 25,bottom: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    const Text(
                      'Reset Password',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                          fontFamily: "LocalFont",
                          letterSpacing: 1
                      ),
                    ),
                    SizedBox(height: 20),


                    CustomTextField(
                      label: 'Enter Email',
                      controller: _emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),


                    ButtonWidget(
                      text: "Reset",
                      width: 2.5,
                      loading: loading,
                      txtColor: Colors.white,
                      backColor: Colors.green.shade400,
                      onTap: () {
                        forgetPass(_emailController.text.toString());
                      }
                    ),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}