import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    super.key,
    required this.height,
    required this.width,
    required this.labelText,
    required this.textInputType,
    required this.controller,
    this.textFieldIcon,
    this.hintText,
    this.leftMargin = 0,
    this.rightMargin = 0,
    this.obscureText = false,
  });

  double height, width;
  String labelText;
  TextInputType textInputType;
  TextEditingController controller;
  Icon? textFieldIcon;
  String? hintText;
  double? leftMargin, rightMargin;
  bool? obscureText;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: EdgeInsets.only(
        left: leftMargin!,
        right: rightMargin!,
      ),
      child: TextField(
        obscureText: obscureText!,
        controller: controller,
        textInputAction: TextInputAction.next,
        keyboardType: textInputType,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          border: OutlineInputBorder(),
          icon: textFieldIcon,
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }
}
