import 'package:flutter/material.dart';

class ProfileTextField extends StatelessWidget {
  TextEditingController? controller;
  final String? hintText, labelText;
  final String? validator;
  final bool enableSuggestions, autoCorrect, obscureText;
  final TextInputType? keyboard;
  ProfileTextField(
      {Key? key,
      this.controller,
      this.hintText,
      this.labelText,
      this.autoCorrect = true,
      this.enableSuggestions = true,
      this.obscureText = false,
      this.keyboard,
      this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboard,
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
            labelText: labelText,
            labelStyle: TextStyle(color: Colors.black, fontSize: 12)),
      ),
    );
  }
}
