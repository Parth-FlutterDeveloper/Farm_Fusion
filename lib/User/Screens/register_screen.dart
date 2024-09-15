import 'package:farm_booking_app/Services/database.dart';
import 'package:farm_booking_app/Utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Common Widget/button_widget.dart';
import '../../Services/shared_preference.dart';
import '../Widgets/Login & Register Widget/custom_text_field.dart';
import '../../Routes/routes_name.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  var indiaPin = "+91 ";
  bool loading = false;
  bool verifyLoading = false;
  bool isChecked = false;
  final _formKey = GlobalKey<FormState>();
  SharedPreferenceHelper spHelper = SharedPreferenceHelper();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _phoneNumberController  = TextEditingController();

  DatabaseMethod dbMethod = DatabaseMethod();
  FirebaseAuth userCredential = FirebaseAuth.instance;

  Future<void> verifyPhone() async {
    setState(() {
      verifyLoading = true;
    });
    if(_phoneNumberController.text.isNotEmpty) {
      await userCredential.verifyPhoneNumber(
          phoneNumber: indiaPin + _phoneNumberController.text,
          verificationCompleted: (_){},
          verificationFailed: (e) {
            Utils().redToastMessage("Something Went Wrong\nPlease Try Later");
            setState(() {
              verifyLoading = false;
            });
          },
          codeSent: (String verificationId, int? token) {
            Get.toNamed(
                RoutesName.codeVerification,
                arguments: verificationId
            );
            setState(() {
              verifyLoading = false;
            });
          },
          codeAutoRetrievalTimeout: (e) {
            setState(() {
              verifyLoading = false;
            });
          }
      );
    }else{
      Utils().redToastMessage("Please Enter Valid Number");
      setState(() {
        verifyLoading = false;
      });
    }
  }


  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      if(isChecked){
        setState(() {
          loading = true;
        });
        try {
          await userCredential.createUserWithEmailAndPassword(
            email: _emailController.text.toString(),
            password: _passwordController.text.toString(),
          );
          //---------- Add User Details ------------
          String id = DateTime.now().millisecondsSinceEpoch.toString();
          String role = "user";
          Map<String, dynamic> userInfoMap = {
            "Id": id,
            "Role": role,
            "Name": _nameController.text,
            "Email": _emailController.text,
            "Password": _passwordController.text,
            "City": _cityController.text,
            "Phone Number": indiaPin + _phoneNumberController.text
          };
          dbMethod.addUserDetails(userInfoMap, id);
          //----------------------------------------
          setState(() {
            loading = false;
          });
          Utils().toastMessage("Successfully Signed Up");
          Get.offNamed(RoutesName.loginScreen.toString());
        } on FirebaseAuthException catch (e) {
          String message;
          if (e.code == 'weak-password') {
            message = 'The password provided is too weak';
          } else if (e.code == 'email-already-in-use') {
            message = 'The account already exists';
          } else {
            message = e.message ?? 'Something went wrong';
          }
          Utils().toastMessage(message);
          setState(() {
            loading = false;
          });
        }
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
                        keyboardType: TextInputType.name,
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
                        keyboardType: TextInputType.emailAddress,
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
                        keyboardType: TextInputType.text,
                        controller: _passwordController,
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
                        keyboardType: TextInputType.text,
                        controller: _cityController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your City';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 15),
                        child: TextFormField(
                          controller: _phoneNumberController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            fillColor: Colors.green.shade50,
                            filled: true,
                            labelText: 'Phone Verification',
                            prefixText: indiaPin,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(11)
                            ),
                          ),
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
                      ),
                      SizedBox(height: 10),

                      Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: ButtonWidget(
                              text: "Verify",
                              width: 4,
                              onTap: () {
                                verifyPhone();
                              },
                            loading: verifyLoading,
                            txtColor: Colors.white,
                            backColor: Colors.green.shade400,
                          ),
                        ),
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
                            color: isChecked ? Colors.green.shade900 : Colors.red,
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
                            _signUp();
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