import 'package:flutter/material.dart';
import '../../../Services/shared_preference.dart';

class ProfileImageWidget extends StatefulWidget {
  const ProfileImageWidget({super.key});

  @override
  State<ProfileImageWidget> createState() => _ProfileImageWidgetState();
}

class _ProfileImageWidgetState extends State<ProfileImageWidget> {

  String? name,email;
  SharedPreferenceHelper spHelper = SharedPreferenceHelper();

  getDataFromSPHelper() async {
    name = await spHelper.getUserName();
    email = await spHelper.getUserEmail();
    setState(() {
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataFromSPHelper();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            print("sddddddddddddd");
          },
          child: Container(
            height: 145,
            width: 145,
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      spreadRadius: 3
                  )
                ]
            ),
            child: CircleAvatar(
              backgroundColor: Colors.green.shade100,
              foregroundImage: AssetImage('assets/images/rendomPerson.png'),
            ),
          ),
        ),
        SizedBox(height: 20),
        Text(name == null ? "Name" : "$name",style: TextStyle(
          fontSize: 23,
          fontFamily: 'LocalFont',
          fontWeight: FontWeight.bold,
          letterSpacing: 1
        ),),
        Text(email == null ? "Email" : "$email",style: TextStyle(
            fontSize: 17,
            fontFamily: 'LocalFont',
            fontWeight: FontWeight.bold,
            letterSpacing: 1
        ),)
      ],
    );
  }
}
