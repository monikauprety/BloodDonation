import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool obscureText;
  final Icon? icon;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.labelText,
    this.obscureText = false,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 30, left: 30, bottom: 5, top: 5),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          icon: icon,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(width: 3, color: Colors.red), //<-- SEE HERE
            borderRadius: BorderRadius.circular(50.0),
          ),
          labelText: labelText,
        ),
        obscureText: obscureText,
      ),
    );
  }
}
