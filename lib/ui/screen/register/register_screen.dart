import 'package:flutter/material.dart';
import 'package:mygreenapp/app/routes.dart';

import 'register_body.dart';
import 'register_viewmodel.dart';

class RegisterScreen extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (_) => RegisterScreen());

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailField = TextEditingController();
  final phoneField = TextEditingController();
  final addrsField = TextEditingController();
  final codeField = TextEditingController();
  bool _showPassword = false;

  RegisterViewmodel viewmodel = RegisterViewmodel();
  get showPassword => _showPassword;
  set showPassword(value) => setState(() => _showPassword = value);

  void addUser() async {
    dynamic result;
    try {
      result = await viewmodel.addUser(
          email: emailField.text,
          password: passwordController.text,
          name: usernameController.text,
          address: addrsField.text,
          phone: phoneField.text);
      final _user = viewmodel.user;
      if (_user != null) Navigator.pushNamed(context, Routes.homeRoute);
      if (result == 'email-already-in-use') {
        showAlertDialog(context, "Email is registered.");
      } else if (result == "weak-password") {
        showAlertDialog(context, "Weak password");
      } else if (result == 'invalid-email') {
        showAlertDialog(context, "Invalid email address.");
      }
    } catch (e) {
      showAlertDialog(context, "Something went wrong");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RegisterBody(this),
    );
  }

  showAlertDialog(BuildContext context, String text) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pushNamed(context, Routes.homeRoute);
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
