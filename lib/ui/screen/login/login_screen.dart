import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mygreenapp/app/app.dart';
import 'package:mygreenapp/ui/screen/login/login_body.dart';

//import 'login_body.dart';
import 'login_viewmodel.dart';
import '../../../model/user.dart';


class LoginScreen extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (_) => LoginScreen());

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool _showPassword = false;

  //LoginViewmodel viewmodel = LoginViewmodel();
  get showPassword => _showPassword;
  set showPassword(value) => setState(() => _showPassword = value);

  void onLogin(LoginViewmodel viewmodel) async {
    dynamic result;
    try {
      result = await viewmodel.signIn(
          email: usernameController.text, password: passwordController.text);
      final _user = viewmodel.user.copyWith();
      print(_user);

      final docUser= FirebaseFirestore.instance.collection('User').doc(_user.uid);
      final snapshot=await docUser.get();
      
      
      if(snapshot.exists)
      {
         String role=User.fromJson(snapshot.data()!).role;
         if (role=="user")
         {
           print("user page");
           Navigator.pushNamed(context, Routes.homeRoute);
         }
         else if(role=="Admin")
         {
           print("admin page");
           Navigator.pushNamed(context, Routes.adminRoute);
         }
         else{
           print("error");
           throw 'error occur in reading user role';
         }
      }
      else
      {
        throw 'error occur in reading user role';
      }
    } catch (e) {
      /*  if (e == 'user-not-found') {
        showAlertDialog(context, 'You are not registered.');
      } else if (e == 'wrong-password') {
        showAlertDialog(context, 'Wrong password.');
      } */
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
        Navigator.pushNamed(context, Routes.loginRoute);
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
