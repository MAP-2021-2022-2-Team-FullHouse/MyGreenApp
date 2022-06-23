import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RedeemTextField extends StatefulWidget {
  TextEditingController? controller;
  final String? hintText, labelText;
  final String? validator;
  final String? error;
  final bool enableSuggestions, autoCorrect, obscureText;
  final TextInputType? keyboard;
  final String?initialValue;
  RedeemTextField(
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
  State<RedeemTextField> createState() => _RedeemTextFieldState();
}

class _RedeemTextFieldState extends State<RedeemTextField> {

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
    
   
   if (widget.labelText == "Phone Number:") {
      String pattern =
          r'^(\+?6?01)[02-46-9]-*[0-9]{7}|^(\+?6?01)[1]-*[0-9]{8}$';
      RegExp regex = RegExp(pattern);
      String match = text!;
      if (!regex.hasMatch(match)) {
        return 'Invalid phone number format';
      }
    }
    return null;
  }
}
