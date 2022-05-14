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

  //LoginViewmodel viewmodel = LoginViewmodel();
  get showPassword => _showPassword;
  set showPassword(value) => setState(() => _showPassword = value);

  void onLogin(LoginViewmodel viewmodel) async {
    await viewmodel.signIn(
        email: usernameController.text, password: passwordController.text);
    final _user = viewmodel.user.copyWith();
    if (_user != null) Navigator.pop(context, _user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginBody(this),
    );
  }
}
