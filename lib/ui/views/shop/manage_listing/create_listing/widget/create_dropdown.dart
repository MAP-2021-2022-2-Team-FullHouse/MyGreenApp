import 'package:flutter/material.dart';
import 'package:my_green_app/ui/views/shop/manage_listing/create_listing/createlisting_screenstate.dart';

class CreateDropdownInput extends StatefulWidget {
  String? currentValue;
  final CreateListingScreenfulState state;
  final List<String>? items;
  final String title;

  CreateDropdownInput(
      {Key? key,
      required this.currentValue,
      required this.items,
      required this.state,
      required this.title})
      : super(key: key);

  @override
  State<CreateDropdownInput> createState() => _CreateDropdownInputState();
}

class _CreateDropdownInputState<T> extends State<CreateDropdownInput> {

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
        hint: const Text('Please choose one option'),
        icon: const Icon(Icons.keyboard_arrow_down),
        items: widget.items?.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text(items),
          );
        }).toList(),
        value: widget.currentValue,
        onChanged: (String? newValue) {
          setState(() {
            if (widget.title == "Category") {
              widget.currentValue = newValue;
              widget.state.currentCategory = widget.currentValue!;
            } else if (widget.title == "Method") {
              widget.currentValue = newValue;
              widget.state.currentMethod = widget.currentValue!;
            }else if (widget.title == "Condition") {
              widget.currentValue = newValue;
              widget.state.currentCondition = widget.currentValue!;
            }
            
          });
        });
  }
}