import 'package:flutter/material.dart';

class ProfileOptionWidget extends StatefulWidget {

  final String text;
  final Color color;
  final Icon icon;

  const ProfileOptionWidget({
    super.key,
    required this.text,
    required this.color,
    required this.icon
  });

  @override
  State<ProfileOptionWidget> createState() => _ProfileOptionWidgetState();
}

class _ProfileOptionWidgetState extends State<ProfileOptionWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20,left: 40,right: 40,bottom: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(11)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              widget.icon,
              SizedBox(width: 15),
              Text(widget.text,style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'LocalFont',
                  fontSize: 23,
                  letterSpacing: 1
              ),)
            ],
          ),
          Icon(Icons.arrow_forward_ios_outlined)
        ],
      ),
    );
  }
}
