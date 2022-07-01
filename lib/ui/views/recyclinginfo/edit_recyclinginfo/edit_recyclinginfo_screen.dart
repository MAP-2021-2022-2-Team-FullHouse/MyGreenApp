import 'package:flutter/material.dart';
import 'edit_recyclinginfo_viewmodel.dart';
import 'edit_recyclinginfo_body.dart';
import 'package:my_green_app/ui/views/recyclinginfo/recyclinginfo_screen.dart';

class EditRecyclingInfoScreen extends StatefulWidget {
  final String infoId;
  const EditRecyclingInfoScreen({Key? key, required this.infoId})
      : super(key: key);
  String get recyclingInfoId => infoId;

  @override
  EditRecyclingInfoScreenState createState() => EditRecyclingInfoScreenState();
}

class EditRecyclingInfoScreenState extends State<EditRecyclingInfoScreen> {
  late String recyclingInfoId;
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  var fileField = TextEditingController();
  String? filename;
  EditRecyclingInfo_ViewModel viewmodel = EditRecyclingInfo_ViewModel();

  void editRecyclingInfo() async {
    dynamic result;
    try {
      result = await viewmodel.editRecyclingInfo(
        infoId: recyclingInfoId,
        title: titleController.text,
        content: contentController.text,
        image: fileField.text,
      );
      if (result == 'ok') {
        // ignore: use_build_context_synchronously
        showConfirmDialog(context, "Edited Successfully!");
      }
    } catch (e) {
      showAlertDialog(context, "Form is not completely filled.");
    }
  }

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
      body: EditRecyclingInfoBody(this),
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
      child: const Text("OK"),
      onPressed: () {
        //Navigator.pushNamed(context, routes.createRecyclingInfoRoute);
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Error"),
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
