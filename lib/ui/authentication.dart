import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Authentication extends StatefulWidget {
  const Authentication({Key? key}) : super(key: key);

  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
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
                TextFormField(
                  controller: _phoneField,
                  decoration: InputDecoration(
                      hintText: "+60123456789",
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                      labelText: "Phone Number: ",
                      labelStyle: TextStyle(color: Colors.black, fontSize: 12)),
                ),
                SizedBox(
                  height: 5.0,
                ),
                TextFormField(
                  controller: _nameField,
                  decoration: InputDecoration(
                      hintText: "Ali bin Abu",
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                      labelText: "Full Name: ",
                      labelStyle: TextStyle(color: Colors.black, fontSize: 12)),
                ),
                SizedBox(
                  height: 5.0,
                ),
                TextFormField(
                  controller: _emailField,
                  decoration: InputDecoration(
                      hintText: "abc@email.com",
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                      labelText: "Email: ",
                      labelStyle: TextStyle(color: Colors.black, fontSize: 12)),
                ),
                SizedBox(
                  height: 5.0,
                ),
                TextFormField(
                  controller: _pwdField,
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: "password",
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                      labelText: "Password: ",
                      labelStyle: TextStyle(color: Colors.black, fontSize: 12)),
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
                TextFormField(
                  controller: _addrsField,
                  decoration: InputDecoration(
                      hintText: "No.,Jalan,Taman",
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                      labelText: "Address: ",
                      labelStyle: TextStyle(color: Colors.black, fontSize: 12)),
                ),
                SizedBox(
                  height: 5.0,
                ),
                TextFormField(
                  controller: _codeField,
                  decoration: InputDecoration(
                      hintText: "123456",
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                      labelText: "Postcode: ",
                      labelStyle: TextStyle(color: Colors.black, fontSize: 12)),
                ),
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
                    child: MaterialButton(
                        onPressed: () {}, child: Text("Go Green!"))),
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
