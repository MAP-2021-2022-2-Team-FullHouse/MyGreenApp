import 'package:flutter/material.dart';

class ResetTextField extends StatefulWidget {
  TextEditingController? controller;
  final String? hintText, labelText,errors;
  final bool enableSuggestions, autoCorrect, obscureText;
  final IconData iconName;

  final TextInputType? keyboard;
  ResetTextField(
      {this.controller,
      this.hintText,
      this.labelText,
      required this.iconName,
      this.autoCorrect = true,
      this.enableSuggestions = true,
      this.obscureText = false,
      this.errors,
      this.keyboard});

  @override
  State<ResetTextField> createState() => _ResetTextFieldState();
}

class _ResetTextFieldState extends State<ResetTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.obscureText,
        keyboardType: widget.keyboard,
        autocorrect: widget.autoCorrect,
        enableSuggestions: widget.enableSuggestions,
        onChanged: (text) => setState(() => ""),
        decoration: InputDecoration(
          filled: true,
          fillColor: Color.fromRGBO(242, 255, 231, 100),
          hintText: widget.hintText,
          labelText: widget.labelText,
          errorText: errors,
          hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
          prefixIcon: Padding(
            padding: EdgeInsets.only(top: 1), // add padding to adjust icon
            child: Icon(widget.iconName),
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

  String? get errors {
    final String? text = widget.controller?.text;

    if (text == "") {
      return 'This field is required.';
    }
    if (text != "") {
      //String pattern = r'\w+@\w+\.\w+';
      String pattern =
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
      RegExp regex = RegExp(pattern);
      String match = text!;
      if (!regex.hasMatch(match)) {
        return 'Invalid email format.';
      }
    }
    return null;
  }
}
