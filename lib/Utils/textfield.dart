 import 'package:flutter/material.dart';
import 'package:learning_project/Utils/App_color.dart';

class Textfield extends StatelessWidget {
  Textfield({
    super.key,
    this.keyboardType = TextInputType.emailAddress,
    this.labelText,
    this.prefix,
    this.suffex,
    this.obscureText = false,
    required this.controller,
    this.textalign = TextAlign.left,
  });

  Widget? prefix;
  String? labelText;
  TextInputType? keyboardType;
  Widget? suffex;
  bool obscureText;
  TextEditingController controller;
  TextAlign textalign;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.bold,
        letterSpacing: 2,
      ),
      cursorColor: AppColor.primeColor,
      cursorWidth: 5,
      textAlign: textalign,
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        prefixIcon: prefix,
        suffixIcon: suffex,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        labelText: labelText,
      ),
      obscureText: obscureText,
    );
  }
}
