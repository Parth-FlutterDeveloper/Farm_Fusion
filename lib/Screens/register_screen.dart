import 'package:farm_booking_app/Widgets/Common%20Widget/button_widget.dart';
import 'package:farm_booking_app/Widgets/Common%20Widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Routes/routes_name.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  bool loading = false;
  bool isChecked = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController  = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  // Future<void> _signUp() async {
  //   if (_formKey.currentState!.validate()) {
  //     try {
  //       UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //         email: _emailController.text,
  //         password: _passwordController.text,
  //       );
  //       // Handle successful sign-up, e.g., navigate to another screen
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Successfully signed up")));
  //       Get.toNamed(RoutesName.loginScreen.toString());
  //     } on FirebaseAuthException catch (e) {
  //       String message;
  //       if (e.code == 'weak-password') {
  //         message = 'The password provided is too weak.';
  //       } else if (e.code == 'email-already-in-use') {
  //         message = 'The account already exists for that email.';
  //       } else {
  //         message = e.message ?? 'An unknown error occurred.';
  //       }
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text(message)),
  //       );
  //     }
  //   }
  // }

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
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 11,right: 11,top: 25,bottom: 10),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[

                      const Text("Sign Up",style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                      fontFamily: "LocalFont",
                      letterSpacing: 2
                      ),),
                      SizedBox(height: 25),


                      CustomTextField(
                        label: 'Name',
                        controller: _nameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),


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
                      SizedBox(height: 10),


                      CustomTextField(
                        label: 'Password',
                        controller: _passwordController,
                        isPassword: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters long';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),


                      CustomTextField(
                        label: 'City',
                        controller: _confirmPasswordController,
                        isPassword: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your City';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),


                      CustomTextField(
                        label: 'Phone Verification',
                        controller: _phoneNumberController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          if (!RegExp(r'^\+?[0-9]{10,13}$').hasMatch(value)) {
                            return 'Please enter a valid phone number';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),


                      CheckboxListTile(
                        value: isChecked,
                        onChanged: (value) {
                          setState(() {
                            isChecked = !isChecked;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                        activeColor: Colors.transparent,
                        checkColor: Colors.green.shade900,
                        title: Text('I accept all your terms and conditions.',
                        style: TextStyle(
                            fontFamily: "LocalFont",
                            color: Colors.green.shade900,
                            fontSize: 17,
                            fontWeight: FontWeight.bold
                        ),),
                      ),

                      const SizedBox(height: 10),

                      ButtonWidget(
                          text: "Register",
                          width: 2,
                          loading: loading,
                          txtColor: Colors.white,
                          backColor: Colors.green.shade400,
                          onTap: () {
                            // if(_formKey.currentState!.validate()){
                            //   if(isChecked){
                            //     Get.offNamed(RoutesName.loginScreen.toString());
                            //   }
                            // }
                            if(isChecked){
                              Get.offNamed(RoutesName.loginScreen.toString());
                            }
                          },
                      ),

                      const SizedBox(height: 10),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already have an account?",style: TextStyle(
                              fontFamily: "LocalFont",
                              fontSize: 15,
                              fontWeight: FontWeight.bold
                          ),),
                          TextButton(
                            onPressed: () {
                              Get.offNamed(RoutesName.loginScreen.toString());
                            },
                            child: Text('Login Here',style: TextStyle(
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