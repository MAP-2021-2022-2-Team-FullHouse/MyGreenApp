import 'package:flutter/material.dart';
import 'package:mygreenapp/ui/screen/login/login_body.dart';

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

  LoginViewmodel viewmodel = LoginViewmodel();
  get showPassword => _showPassword;
  set showPassword(value) => setState(() => _showPassword = value);

  void onLogin() async {
    await viewmodel.signIn(
        email: usernameController.text, password: passwordController.text);
    final user = viewmodel.user;
    if (user != null) Navigator.pop(context, user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginBody(this),
    );
  }
}
