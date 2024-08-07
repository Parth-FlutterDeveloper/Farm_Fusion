import 'package:farm_booking_app/Routes/routes_name.dart';
import 'package:farm_booking_app/Utils/utils.dart';
import 'package:farm_booking_app/Widgets/Common%20Widget/button_widget.dart';
import 'package:farm_booking_app/Widgets/Common%20Widget/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool loading = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        Get.offAllNamed(RoutesName.navbarWidget.toString());
        Utils().toastMessage("Login Successfully");
        setState(() {
          loading = false;
        });
      } on FirebaseAuthException catch (e) {
        Utils().redToastMessage('Login Failed !!');
        setState(() {
          loading = false;
        });
      }
    }
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
                padding: const EdgeInsets.only(left: 11,right: 11,top: 25,bottom: 10),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Log In',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                            fontFamily: "LocalFont",
                            letterSpacing: 2
                        ),
                      ),

                      SizedBox(height: 30),

                      CustomTextField(
                        label: 'Email',
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

                      SizedBox(height: 16),

                      CustomTextField(
                        label: 'Password',
                        controller: _passwordController,
                        isPassword: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 6){
                            return 'Please enter 6 character';
                          }
                          return null;
                        },
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                Get.toNamed(RoutesName.forgotPassword.toString());
                              },
                              child: Text('Forget Password',style: TextStyle(
                                fontFamily: "LocalFont",
                                color: Colors.green.shade800,
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                              ),),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 5),

                      ButtonWidget(
                        text: "Log In",
                        width: 2,
                        loading: loading,
                        txtColor: Colors.white,
                        backColor: Colors.green.shade400,
                        onTap: () {
                          _login();
                        },
                      ),

                      SizedBox(height: 5),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have any account?",style: TextStyle(
                              fontFamily: "LocalFont",
                              fontSize: 14,
                              fontWeight: FontWeight.bold
                          ),),
                          TextButton(
                            onPressed: () {
                              Get.offNamed(RoutesName.registerScreen.toString());
                            },
                            child: Text('Register Here',style: TextStyle(
                                fontFamily: "LocalFont",
                                color: Colors.green.shade800,
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                            ),),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
