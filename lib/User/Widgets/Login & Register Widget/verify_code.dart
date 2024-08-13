import 'package:farm_booking_app/Utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Common Widget/button_widget.dart';

class CodeVerification extends StatefulWidget {
  final String verificationId;
  const CodeVerification({
    super.key,
    required this.verificationId,
  });

  @override
  State<CodeVerification> createState() => _CodeVerificationState();
}

class _CodeVerificationState extends State<CodeVerification> {
  final auth = FirebaseAuth.instance;
  bool loading = false;
  final TextEditingController _otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();


  Future<void> verifyCode() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });
      try {

        PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: widget.verificationId,
          smsCode: _otpController.text.trim(),
        );
        UserCredential userCredential = await auth.signInWithCredential(credential);
        if (auth.currentUser != null) {
          await auth.currentUser!.delete();
        }
        Utils().toastMessage("Verified Successfully");
        Get.back();

      } catch (e) {
        Utils().redToastMessage("Verification failed. Please try again.");
      } finally {
        setState(() {
          loading = false;
        });
      }
    } else {
      Utils().redToastMessage("Please enter a valid OTP.");
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
                padding: const EdgeInsets.only(
                    left: 11, right: 11, top: 25, bottom: 10),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Verify',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                            fontFamily: "LocalFont",
                            letterSpacing: 2),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Enter 6 digits verification \ncode sent to your number",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          fontFamily: "LocalFont",
                          letterSpacing: 1,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 2.0, horizontal: 15),
                        child: TextFormField(
                          controller: _otpController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Please Enter OTP',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(11)),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your OTP';
                            }
                            if (value.length != 6) {
                              return 'Please enter 6 characters';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      ButtonWidget(
                        text: "Verify",
                        width: 2.5,
                        loading: loading,
                        txtColor: Colors.white,
                        backColor: Colors.green.shade400,
                        onTap: () {
                          verifyCode();
                        },
                      ),
                      const SizedBox(height: 5),
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
