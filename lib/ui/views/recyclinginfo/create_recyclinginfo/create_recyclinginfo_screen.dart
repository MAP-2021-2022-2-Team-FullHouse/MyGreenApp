import 'package:flutter/material.dart';
import 'create_recyclinginfo_viewmodel.dart';
import 'create_recyclinginfo_body.dart';
import 'package:my_green_app/ui/views/recyclinginfo/recyclinginfo_screen.dart';

// ignore: use_key_in_widget_constructors
class CreateRecyclingInfoScreen extends StatefulWidget {
  static Route route() =>
      MaterialPageRoute(builder: (_) => CreateRecyclingInfoScreen());

  @override
  CreateRecyclingInfoScreenState createState() =>
      CreateRecyclingInfoScreenState();
}

class CreateRecyclingInfoScreenState extends State<CreateRecyclingInfoScreen> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  var fileField = TextEditingController();
  String? filename;
  CreateRecyclingInfo_ViewModel viewmodel = CreateRecyclingInfo_ViewModel();

  void addRecyclingInfo() async {
    dynamic result;
    try {
      result = await viewmodel.addRecyclingInfo(
        title: titleController.text,
        content: contentController.text,
        image: fileField.text,
      );
      if (result == 'ok') {
        // ignore: use_build_context_synchronously
        showConfirmDialog(context, "Created Successfully!");
      }
    } catch (e) {
      showAlertDialog(context, "Something went wrong.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(
          'Recycling Info',
          style: TextStyle(color: Colors.black.withOpacity(1.0)),
        ),
      ),
      body: CreateRecyclingInfoBody(this),
    );
  }

  showConfirmDialog(BuildContext context, String text) {
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        //Navigator.pushNamed(context, Routes.homeRoute);
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const RecyclingInfoScreen(),
        ));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Message"),
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
        //Navigator.pushNamed(context, routes.createRecyclingInfoRoute);
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
