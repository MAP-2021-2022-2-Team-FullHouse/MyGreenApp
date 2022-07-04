import 'package:flutter/material.dart';

// ignore: must_be_immutable
class EditMultiLineTextField extends StatefulWidget {
  TextEditingController? controller;
  final String? hintText, labelText;
  final String? validator;
  final String? error;
  final bool enableSuggestions, autoCorrect, obscureText;
  final TextInputType? keyboard;
  final String? initialValue;
  EditMultiLineTextField({
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
  State<EditMultiLineTextField> createState() => _EditMultiLineTextFieldState();
}

class _EditMultiLineTextFieldState extends State<EditMultiLineTextField> {
  //var _text = '';
  TextInputType? key;
  get controller => widget.controller;
  get keyboard => key;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        controller: widget.controller,
        minLines: 5,
        maxLines: 30,
        keyboardType: keyboard,
        initialValue: widget.initialValue,
        decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 12),
            labelText: widget.labelText,
            border: const OutlineInputBorder(),
            labelStyle: const TextStyle(color: Colors.black, fontSize: 12)),
        onChanged: (text) => setState(() => ""),
      ),
    );
  }
}
