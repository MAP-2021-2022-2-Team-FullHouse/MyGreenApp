import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditTextField extends StatefulWidget {
  TextEditingController? controller;
  final String? hintText, labelText;
  final String? validator;
  final String? error;
  final bool enableSuggestions, autoCorrect, obscureText;
  final TextInputType? keyboard;
  final String?initialValue;
  final RegExp? regexp;
  EditTextField(
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
      this.regexp,
      })
      : super(key: key);

  @override
  State<EditTextField> createState() => _EditTextFieldState();
}

class _EditTextFieldState extends State<EditTextField> {
  TextInputType? key;
  get controller => widget.controller;

  bool get obscureText {
    if (widget.labelText == "Password: ") {
      return true;
    } else {
      return false;
    }
  }

  TextInputType get keyboard {
    if (widget.labelText == "Price: ") {
      return TextInputType.number;
    } else {
      return TextInputType.text;
    }
  }

  RegExp get regexp {
    if (widget.labelText == "Price: (RM)") {
      return RegExp(r'^\d+\.?\d{0,2}');
    } else {
      return RegExp(r'^[a-zA-Z0-9 !.,<>()@#$%^&*_\+-:;]+$');
    }
  }

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
      inputFormatters: [FilteringTextInputFormatter.allow(regexp)],
    );
  }

  String? get error {
    final String? text = widget.controller?.text;

    if (text == "") {
      return 'This field is required.';
    }
    return null;
  }
}
