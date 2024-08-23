import 'package:flutter/material.dart';

class RoomRadioButtonWidget extends StatefulWidget {

  final int value;
  final String text;
  final int groupValue;
  final ValueChanged<int?> onChanged;

  const RoomRadioButtonWidget({
    super.key,
    required this.value,
    required this.text,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  State<RoomRadioButtonWidget> createState() => _RoomRadioButtonWidgetState();
}

class _RoomRadioButtonWidgetState extends State<RoomRadioButtonWidget> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        RadioListTile(

          title: Text(widget.text,style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: "LocalFont",
              letterSpacing: 1
          ),),

          activeColor: Colors.indigoAccent,
          value: widget.value,
          groupValue: widget.groupValue,
          onChanged: widget.onChanged,
        )
      ]
    );
  }
}
