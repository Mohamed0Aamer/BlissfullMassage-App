import 'package:flutter/material.dart';

class Textformfieldwidget extends StatelessWidget {
  Textformfieldwidget({
    super.key,
    required this.controller,
    required this.hintText,
    // required this.validator
  });
  TextEditingController controller;
  String hintText;
  // String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      //validator: validator,
      controller: controller,
      style: TextStyle(color: Colors.white, fontSize: 20),
      decoration: InputDecoration(
        fillColor: Color(0xff5483b3),
        filled: true,
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.black),
        border: OutlineInputBorder(),
      ),
    );
  }
}
