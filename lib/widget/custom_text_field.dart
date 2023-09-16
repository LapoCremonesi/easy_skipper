import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
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

  final double height, width;
  final String labelText;
  final TextInputType textInputType;
  final TextEditingController controller;
  final Icon? textFieldIcon;
  final String? hintText;
  final double? leftMargin, rightMargin;
  final bool? obscureText;

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
          border: const OutlineInputBorder(),
          icon: textFieldIcon,
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }
}
