import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ButtonWidget extends StatefulWidget {

  final String text;
  final double width;
  final VoidCallback onTap;
  final bool loading;
  final Color backColor, txtColor;

  const ButtonWidget({
    super.key,
    required this.text,
    required this.width,
    required this.onTap,
    required this.loading,
    required this.backColor,
    required this.txtColor
  });

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        // padding: EdgeInsets.only(bottom: 5),
        height: Get.height / 18,
        width: Get.width / widget.width,
        decoration: BoxDecoration(
          color: widget.backColor,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
          child: widget.loading
          ? CircularProgressIndicator(
            color: Colors.black,
            strokeWidth: 2.5,
          )
          : Text(widget.text,style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              fontFamily: "LocalFont",
              letterSpacing: 1,
              color: widget.txtColor
          ),)
        ),
      ),
    );
  }
}
