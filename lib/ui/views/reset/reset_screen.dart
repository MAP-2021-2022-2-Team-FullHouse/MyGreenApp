import 'package:flutter/material.dart';
import 'package:my_green_app/app/routes.dart';
import 'package:my_green_app/app/app.dart';
import 'package:my_green_app/ui/views/reset/reset_body.dart';
import 'package:my_green_app/ui/views/reset/reset_viewmodel.dart';

class ResetScreen extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (_) => ResetScreen());

  @override
  ResetScreenState createState() => ResetScreenState();
}

class ResetScreenState extends State<ResetScreen> {
  final emailController = TextEditingController();
  ResetViewmodel viewmodel = ResetViewmodel();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  void resetPassword(ResetViewmodel viewmodel) async {
    dynamic result;
    try {
      result = await viewmodel.sendResetPassEmail(
          email: emailController.text.trim());
      if (result == 'invalid-email') {
        // ignore: use_build_context_synchronously
        showAlertDialog(context, "Email entered is invalid.");
      } else if (result == "user-not-found") {
        // ignore: use_build_context_synchronously
        showAlertDialog(context, "Email associated is not found.");
      } else {
        // ignore: use_build_context_synchronously
        showAlertDialog2(
            context, "The password reset link has been sent to your email.");
      }
    } catch (e) {
      showAlertDialog(context, "Something went wrong");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResetBody(this),
    );
  }

  showAlertDialog(BuildContext context, String text) {
    // set up the button
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.pushNamed(context, Routes.resetRoute);
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

  showAlertDialog2(BuildContext context, String text) {
    // set up the button
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        //Navigator.pushNamed(context, Routes.loginRoute);
        //Navigator.of(context).pushNamed(Routes.loginRoute);
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Confirm"),
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
