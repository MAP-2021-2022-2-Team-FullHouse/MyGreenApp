import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mygreenapp/ui/screen/login/login_button.dart';
import 'package:mygreenapp/ui/screen/register/register_view.dart';

class Login extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (_) => Login());
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _userField = TextEditingController();
  TextEditingController _pwdField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(209, 239, 181, 100),
                Color.fromRGBO(211, 250, 214, 100)
              ]),
        ),
        child: Column(
          children: [
            Container(
              child: Image.asset('assets/logo.png', height: 150, width: 250),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              decoration: new BoxDecoration(
                borderRadius: new BorderRadius.circular(16.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(horizontal: 30),
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  controller: _userField,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color.fromRGBO(242, 255, 231, 100),
                    hintText: "Username",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                    prefixIcon: Padding(
                      padding:
                          EdgeInsets.only(top: 1), // add padding to adjust icon
                      child: Icon(Icons.account_circle_outlined),
                    ),
                    //icon: Icon(Icons.account_circle_outlined),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10.0),

                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Colors.green[900]!,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                TextFormField(
                  controller: _pwdField,
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color.fromRGBO(242, 255, 231, 100),
                    hintText: "Password",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                    prefixIcon: Padding(
                      padding:
                          EdgeInsets.only(top: 1), // add padding to adjust icon
                      child: Icon(Icons.key),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10.0),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Colors.green[900]!,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 10,
                      color: Colors.black,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Register()),
                    );
                  },
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Do not have an account? Sign up",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 10,
                        color: Colors.black,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                    width: MediaQuery.of(context).size.width / 2.5,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color.fromRGBO(195, 196, 141, 100),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 3,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: LoginButton(
                        email: _userField.text, password: _pwdField.text)),
                SizedBox(
                  height: 10.0,
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
