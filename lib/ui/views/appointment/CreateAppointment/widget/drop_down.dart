import 'package:flutter/material.dart';
import 'package:my_green_app/ui/views/appointment/CreateAppointment/create_appointment_screen.dart';

class DropDown extends StatefulWidget {
  String? currentValue;
  final CreateAppointmentScreenState dropDownState;
  final List<String>? items;

  DropDown(
      {Key? key,
      required this.currentValue,
      required this.items,
      required this.dropDownState})
      : super(key: key);

  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton(

        // Initial Value
        value: widget.currentValue,

        // Down Arrow Icon
        icon: const Icon(Icons.keyboard_arrow_down),

        // Array list of items
        items: widget.items?.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text(items),
          );
        }).toList(),
        // After selecting the desired option,it will
        // change button value to selected value
        onChanged: (String? newValue) {
          setState(() {
            if (widget.currentValue == "Paper" ||
                widget.currentValue == "Glass" ||
                widget.currentValue == "Plastic" ||
                widget.currentValue == "Cloth") {
              widget.currentValue = newValue;
              widget.dropDownState.currentCategory = widget.currentValue!;
            } else if (widget.currentValue == "Self-Delivery" ||
                widget.currentValue == "Pick Up") {
              widget.currentValue = newValue;
              widget.dropDownState.currentMethod = widget.currentValue!;
            }
          });
        });
  }
}
