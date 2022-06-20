import 'package:flutter/material.dart';
import 'package:my_green_app/ui/views/appointment/CreateAppointment/widget/drop_down.dart';
import 'CreateAppointment_Screen.dart';
import 'widget/create_textfield.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

final format = DateFormat("yyyy-MM-dd HH:mm");
final CreateAppointmentScreenState appointmentState =
    CreateAppointmentScreenState();
List<Widget> buildCreateTextFields(CreateAppointmentScreenState state) => [
      CreateTextField(
        controller: state.nameController,
        hintText: "Name your item: Newspaper",
        labelText: "Name: ",
      ),
      const SizedBox(
        height: 5.0,
      ),
      CreateTextField(
        controller: state.quantityField,
        hintText: "5 boxes / 10kg",
        labelText: "Quantity: ",
      ),
      const SizedBox(
        height: 5.0,
      ),
      const Align(
        alignment: Alignment.centerLeft,
        child: Text("Category",
            textAlign: TextAlign.left,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
      ),
      Align(
        alignment: Alignment.centerLeft,
        child: DropDown(
          currentValue: appointmentState.currentCategory,
          items: appointmentState.categories,
          dropDownState: state,
        ),
      ),
      const SizedBox(
        height: 5.0,
      ),
      Align(
        alignment: Alignment.centerLeft,
        child: Text("Delivery Method",
            textAlign: TextAlign.left,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
      ),
      Align(
        alignment: Alignment.centerLeft,
        child: DropDown(
          currentValue: appointmentState.currentMethod,
          items: appointmentState.methods,
          dropDownState: state,
        ),
      ),
      const SizedBox(
        height: 5.0,
      ),
      const Align(
        alignment: Alignment.centerLeft,
        child: Text("Appointment Date and Time",
            textAlign: TextAlign.left,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
      ),
      DateTimeField(
        controller: state.dateTimeField,
        format: format,
        onShowPicker: (context, currentValue) async {
          final date = await showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
          if (date != null) {
            final time = await showTimePicker(
              context: context,
              initialTime:
                  TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
            );
            return DateTimeField.combine(date, time);
          } else {
            return currentValue;
          }
        },
      ),
      const SizedBox(
        height: 5.0,
      ),
      CreateTextField(
        controller: state.remarkField,
        hintText: "You can note down any description",
        labelText: "Remark: ",
      ),
      const SizedBox(
        height: 5.0,
      ),
    ];
