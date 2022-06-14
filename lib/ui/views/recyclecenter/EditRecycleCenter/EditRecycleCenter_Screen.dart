import 'package:flutter/material.dart';
import 'package:my_green_app/model/RecycleCenter.dart';
import 'package:my_green_app/ui/views/recyclecenter/recyclecenter_screen.dart';
import 'package:my_green_app/ui/views/recyclecenter/recyclecenter_viewmodel.dart';
import 'EditRecycleCenter_ViewModel.dart';
import 'EditRecycleCenter_body.dart';

class EditRecycleCenterScreen extends StatefulWidget {
  final String docEmail;
  const EditRecycleCenterScreen({Key? key, required this.docEmail})
      : super(key: key);
  String get rcEmail => docEmail;
  @override
  EditRecycleCenterScreenState createState() => EditRecycleCenterScreenState();
}

class EditRecycleCenterScreenState extends State<EditRecycleCenterScreen> {
  late String rcEmail;
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailField = TextEditingController();
  final phoneField = TextEditingController();
  final addrsField = TextEditingController();
  var latField = TextEditingController();
  var lonField = TextEditingController();
  var fileField = TextEditingController();
  bool _showPassword = false;
  String? filename;
  EditRecycleCenter_ViewModel viewmodel = EditRecycleCenter_ViewModel();
  RecycleCenterViewmodel rcvm = RecycleCenterViewmodel();
  get showPassword => _showPassword;
  set showPassword(value) => setState(() => _showPassword = value);

  Widget build(BuildContext context) {
    rcEmail = widget.docEmail;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        // Here we take the value from the MyHomePage object that was Editd by
        // the App.build method, and use it to set our appbar title.
        title: Text(
          'Edit Recycle Center',
          style: TextStyle(color: Colors.black.withOpacity(1.0)),
        ),
      ),
      body: EditRecycleCenterBody(this),
    );
  }

  void editRecycleCenter() async {
    dynamic result;
    try {
      result = await viewmodel.editRecycleCenter(
        oriemail: rcEmail,
        name: nameController.text,
        address: addrsField.text,
        phone: phoneField.text,
        image: fileField.text,
        email: emailField.text,
        lat: double.parse(latField.text),
        lon: double.parse(lonField.text),
        password: passwordController.text,
      );
      print(result);
      if (result != null) {
        if (result == 'Email is registered.') {
          showAlertDialog(context, "Email is registered by others.");
        } else if (result == "weak-password") {
          showAlertDialog(context, "Weak password.");
        } else if (result == 'invalid-email') {
          showAlertDialog(context, "Invalid email address.");
        } else if (result == "Name duplicated") {
          showAlertDialog(context,
              "This recycle center name is already registered by others.");
        } else if (result == "Phone duplicated") {
          showAlertDialog(
              context, "This phone is already registered by others.");
        } else {
          showConfirmDialog(context, "Edit Successfully!");
        }
      }
    } catch (e) {
      showAlertDialog(context, "Form is not completely filled.");
    }
  }

  showConfirmDialog(BuildContext context, String text) {
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => RecycleCenterScreen(),
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
