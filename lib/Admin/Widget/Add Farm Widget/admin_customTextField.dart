import 'package:flutter/material.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType keyboardType;
  final int? maxLines;
  final int? maxLength;
  final Widget? prefixIcon;
  final String? prefixText;
  final String? Function(String?)? validator;

  const CustomTextFieldWidget({
    super.key,
    required this.controller,
    required this.label,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.maxLength,
    this.prefixIcon,
    this.prefixText,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 2.0),
          child: Row(
            children: [
              SizedBox(width: 2),
              Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green.shade700
                ),
              ),
              SizedBox(width: 10),
              Text("$label",style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: "LocalFont",
                  letterSpacing: 1
              ),)
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 23, top: 8, bottom: 16),
          child: TextFormField(
            validator: validator,
            controller: controller,
            keyboardType: keyboardType,
            maxLines: maxLines,
            maxLength: maxLength,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(11),
              ),
              prefixIcon: prefixIcon,
              prefixText: prefixText,
            ),
          ),
        ),
      ],
    );
  }
}
