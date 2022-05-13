import 'package:flutter/material.dart';

class RegisterTextField extends StatelessWidget {
  TextEditingController? controller;
  final String? hintText, labelText;
  final bool enableSuggestions, autoCorrect, obscureText;
  final TextInputType? keyboard;
  RegisterTextField(
      {this.controller,
      this.hintText,
      this.labelText,
      this.autoCorrect = true,
      this.enableSuggestions = true,
      this.obscureText = false,
      this.keyboard});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
            labelText: labelText,
            labelStyle: TextStyle(color: Colors.black, fontSize: 12)),
      ),
    );
  }
}
