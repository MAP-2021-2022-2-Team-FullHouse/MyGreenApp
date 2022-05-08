import 'package:flutter/material.dart';

class Login extends StatefulWidget {
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
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
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
                  height: 5.0,
                ),
                TextFormField(
                  controller: _userField,
                  decoration: InputDecoration(
                    hintText: "Username",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                TextFormField(
                  controller: _pwdField,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Password",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ),
                Text(
                  "Forgot Password?",
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.black,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                Text(
                  "Do not have an account? Sign up",
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.black,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Container(
                    width: MediaQuery.of(context).size.width / 1.4,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color.fromRGBO(195, 196, 141, 100),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 3,
                          offset: Offset(0, 2), // changes position of shadow
                        ),
                      ],
                    ),
                    child:
                        MaterialButton(onPressed: () {}, child: Text("Login"))),
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
