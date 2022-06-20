import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CreateTextField extends StatefulWidget {
  TextEditingController? controller;
  final String? hintText, labelText;
  final String? validator;
  final String? error;
  final bool enableSuggestions, autoCorrect, obscureText;
  final TextInputType? keyboard;
  final String?initialValue;
  CreateTextField(
      {Key? key,
      this.controller,
      this.hintText,
      this.labelText,
      this.initialValue,
      this.autoCorrect = true,
      this.enableSuggestions = true,
      this.obscureText = false,
      this.keyboard,
      this.validator,
      this.error,
      })
      : super(key: key);

  @override
  State<CreateTextField> createState() => _CreateTextFieldState();
}

class _CreateTextFieldState extends State<CreateTextField> {

  TextInputType? key;
  get controller => widget.controller;

  bool get obscureText {
    if (widget.labelText == "Password: ") {
      return true;
    } else {
      return false;
    }
  }

  get keyboard => key;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: obscureText,
      keyboardType: keyboard,
      initialValue:widget.initialValue,
      decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 12),
          labelText: widget.labelText,
          errorText: error,
          labelStyle: const TextStyle(color: Colors.black, fontSize: 12)),
      onChanged: (text) => setState(() => ""),
    );
  }



  String? get error {
    final String? text = widget.controller?.text;

    if (text == "") {
      return 'This field is required.';
    }
    if (widget.labelText == "Quantity:") {
      String pattern =r'^\d+$';
      RegExp regex = RegExp(pattern);
      String match = text!;
      if (!regex.hasMatch(match)||int.parse(text)<=0) {
        return 'Quantity should be an integer of more than 0';
      }
    }
   
    if (widget.labelText == "Points to Redeem:") {
     String pattern = r'^\d+$';
      RegExp regex = RegExp(pattern);
      String match = text!;
      if (!regex.hasMatch(match)||int.parse(text)<=0) {
        return 'Redeem points should be an integer of more than 0';
      }
    }
    return null;
  }
}
