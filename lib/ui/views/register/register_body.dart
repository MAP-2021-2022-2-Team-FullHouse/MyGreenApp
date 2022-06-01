// import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_green_app/ui/views/register/register_textfields.dart';
import 'package:stacked/stacked.dart';
import 'register_button.dart';
import 'register_screen.dart';
import 'register_viewmodel.dart';

class RegisterBody extends StatelessWidget {
  final RegisterScreenState _state;

  RegisterBody(this._state);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RegisterViewmodel>.reactive(
      builder: (context, viewmodel, _) => Scaffold(
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
                  child: Column(children: [
                Container(
                  child:
                      Image.asset('assets/logo.png', height: 150, width: 250),
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
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
                      ...buildRegisterTextFields(_state),
                      if (viewmodel.errorMessage != null)
                        Text(
                          viewmodel.errorMessage,
                          style: TextStyle(color: Colors.red, fontSize: 20.0),
                        ),
                      const SizedBox(height: 10.0),
                      RegisterButton(state: _state),
                      SizedBox(
                        height: 10.0,
                      ),
                    ],
                  ),
                )
              ])))),
      viewModelBuilder: () => RegisterViewmodel(),
    );
  }
}
