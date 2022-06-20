import 'package:flutter/material.dart';
import 'package:my_green_app/ui/views/appointment/CreateAppointment/create_appointment_upload.dart';
import 'package:my_green_app/ui/views/appointment/appointment_screen.dart';

import 'CreateAppointment_ViewModel.dart';
import 'CreateAppointment_body.dart';

class CreateAppointmentScreen extends StatefulWidget {
  static Route route() =>
      MaterialPageRoute(builder: (_) => CreateAppointmentScreen());

  @override
  CreateAppointmentScreenState createState() => CreateAppointmentScreenState();
}

class CreateAppointmentScreenState extends State<CreateAppointmentScreen> {
  final nameController = TextEditingController();
  final categoryController = TextEditingController();
  final rcField = TextEditingController();
  final deliveryMethodField = TextEditingController();
  final quantityField = TextEditingController();
  final remarkField = TextEditingController();
  var dateTimeField = TextEditingController();
  var fileField = TextEditingController();
  String? filename;
  CreateAppointment_ViewModel viewmodel = CreateAppointment_ViewModel();
  // Initial Selected Value
  String currentCategory = 'Paper';
  String currentMethod = 'Pick Up';
  // List of items in our dropdown menu
  var categories = [
    'Paper',
    'Glass',
    'Plastic',
    'Cloth',
  ];
  var methods = [
    'Pick Up',
    'Self-Delivery',
  ];
  void addAppointment() async {
    dynamic result;
    try {
      result = await viewmodel.addAppointment(
          name: nameController.text,
          category: currentCategory,
          deliveryMethod: currentMethod,
          remark: remarkField.text,
          quantity: quantityField.text,
          dateTimeInput: dateTimeField.text,
          state: AddImageState());
      print(result);
      if (result != null) {
        showConfirmDialog(context, "Booked Successfully!");
      }
    } catch (e) {
      print(e);
      showAlertDialog(context, "Form is not completely filled.");
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Booking',
          style: TextStyle(color: Colors.black.withOpacity(1.0)),
        ),
      ),
      body: CreateAppointmentBody(this),
    );
  }

  showConfirmDialog(BuildContext context, String text) {
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        //Navigator.pushNamed(context, Routes.homeRoute);
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AppointmentScreen(),
        ));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Message"),
      content: Text(text),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlertDialog(BuildContext context, String text) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        //Navigator.pushNamed(context, routes.createAppointmentRoute);
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Error"),
      content: Text(text),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
