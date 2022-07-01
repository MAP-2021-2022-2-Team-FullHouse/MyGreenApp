import 'package:flutter/material.dart';

// ignore: must_be_immutable
class EditTextField extends StatefulWidget {
  TextEditingController? controller;
  final String? hintText, labelText;
  final String? validator;
  final String? error;
  final bool enableSuggestions, autoCorrect, obscureText;
  final TextInputType? keyboard;
  final String? initialValue;
  EditTextField({
    Key? key,
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
  }) : super(key: key);

  @override
  State<EditTextField> createState() => _EditTextFieldState();
}

class _EditTextFieldState extends State<EditTextField> {
  TextInputType? key;
  get controller => widget.controller;
  get keyboard => key;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: TextFormField(
          controller: widget.controller,
          keyboardType: keyboard,
          initialValue: widget.initialValue,
          decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: const TextStyle(color: Colors.grey, fontSize: 12),
              labelText: widget.labelText,
              border: const OutlineInputBorder(),
              labelStyle: const TextStyle(color: Colors.black, fontSize: 12)),
          onChanged: (text) => setState(() => ""),
        ));
  }
}
