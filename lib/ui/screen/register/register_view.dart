import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mygreenapp/ui/screen/register/register_button.dart';
import 'package:mygreenapp/ui/screen/register/register_textField.dart';

class Register extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (_) => Register());
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController _emailField = TextEditingController();
  TextEditingController _pwdField = TextEditingController();
  TextEditingController _phoneField = TextEditingController();
  TextEditingController _nameField = TextEditingController();
  TextEditingController _addrsField = TextEditingController();
  TextEditingController _codeField = TextEditingController();

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
        child: SingleChildScrollView(
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
                  Text(
                    "Register",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      shadows: [
                        Shadow(
                            color: Colors.grey,
                            offset: Offset(2, 1),
                            blurRadius: 10)
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  RegisterTextField(
                      controller: _phoneField,
                      hintText: "+60123456789",
                      labelText: "Phone Number: "),
                  SizedBox(
                    height: 5.0,
                  ),
                  RegisterTextField(
                      controller: _nameField,
                      hintText: "Ali bin Abu",
                      labelText: "Full Name: "),
                  SizedBox(
                    height: 5.0,
                  ),
                  RegisterTextField(
                    controller: _emailField,
                    hintText: "abc@email.com",
                    labelText: "Email: ",
                    enableSuggestions: false,
                    autoCorrect: false,
                    keyboard: TextInputType.emailAddress,
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  RegisterTextField(
                    controller: _pwdField,
                    hintText: "password",
                    labelText: "Password: ",
                    enableSuggestions: false,
                    autoCorrect: false,
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Location",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  RegisterTextField(
                    controller: _addrsField,
                    hintText: "No.,Jalan,Taman",
                    labelText: "Address: ",
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  RegisterTextField(
                      controller: _codeField,
                      hintText: "123456",
                      labelText: "Postcode: "),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width / 2,
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
                      child: RegisterButton(
                        email: _emailField.text,
                        password: _pwdField.text,
                        phone: _phoneField.text,
                        name: _nameField.text,
                        address: _addrsField.text,
                      )),
                  SizedBox(
                    height: 10.0,
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
