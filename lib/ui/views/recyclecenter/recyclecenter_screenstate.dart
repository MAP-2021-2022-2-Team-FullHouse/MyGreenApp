import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_green_app/constants/routes_path.dart' as routes;
import 'package:my_green_app/ui/views/recyclecenter/recyclecenter_button.dart';
import 'package:my_green_app/ui/views/recyclecenter/recyclecenter_body.dart';
import 'package:my_green_app/ui/views/recyclecenter/recyclecenter_viewmodel.dart';

class RecycleCenterScreenful extends StatefulWidget {
  static Route route() =>
      MaterialPageRoute(builder: (_) => RecycleCenterScreenful());

  @override
  State<RecycleCenterScreenful> createState() => RecycleCenterScreenfulState();
}

class RecycleCenterScreenfulState extends State<RecycleCenterScreenful> {
  void onDelete(RecycleCenterViewmodel viewmodel, String email) async {
    //dynamic result;
    await viewmodel.deleteCenter(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: RecycleCenterBody(this));
  }
}

showAlertDialog(BuildContext context, String text) {
  // set up the button
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.pushNamed(context, routes.loginRoute);
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
