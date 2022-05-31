import 'package:flutter/material.dart';

class LoginTextField extends StatelessWidget {
  TextEditingController? controller;
  final String? hintText;
  final bool enableSuggestions, autoCorrect, obscureText;
  final IconData iconName;

  final TextInputType? keyboard;
  LoginTextField(
      {this.controller,
      this.hintText,
      required this.iconName,
      this.autoCorrect = true,
      this.enableSuggestions = true,
      this.obscureText = false,
      this.keyboard});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboard,
        autocorrect: autoCorrect,
        enableSuggestions: enableSuggestions,
        decoration: InputDecoration(
          filled: true,
          fillColor: Color.fromRGBO(242, 255, 231, 100),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
          prefixIcon: Padding(
            padding: EdgeInsets.only(top: 1), // add padding to adjust icon
            child: Icon(iconName),
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: Colors.green[900]!,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: Colors.black,
              width: 1,
            ),
          ),
        ),
      ),
    );
  }
}
