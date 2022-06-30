import 'package:flutter/material.dart';
import 'package:my_green_app/ui/views/login/login_body.dart';
import 'package:my_green_app/constants/routes_path.dart' as routes;
import 'package:my_green_app/app/router.dart' as router;
//import 'login_body.dart';
import 'login_viewmodel.dart';

class LoginScreen extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (_) => LoginScreen());

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool _showPassword = false;

  get showPassword => _showPassword;
  set showPassword(value) => setState(() => _showPassword = value);

  void onLogin(LoginViewmodel viewmodel) async {
    dynamic result;
    try {
      result = await viewmodel.signIn(
          email: usernameController.text, password: passwordController.text);
      //final _user = viewmodel.user.copyWith();
      //print(_user);

    } catch (e) {
      showAlertDialog(context, "Invalid email or password.");
    }
    //if (_user != null) Navigator.pushNamed(context, Routes.homeRoute);
    //Navigator.pop(context, Routes.homeRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginBody(this),
    );
  }

  showAlertDialog(BuildContext context, String text) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        // Navigator.pushNamed(context, routes.loginRoute);
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
