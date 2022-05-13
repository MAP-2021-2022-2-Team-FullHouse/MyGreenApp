import 'package:flutter/material.dart';
import 'package:my_green_app/ui/views/login/login_registerText.dart';
import 'package:my_green_app/ui/views/login/login_textfields.dart';
import 'package:stacked/stacked.dart';
import 'login_button.dart';
import 'login_screen.dart';
import 'login_viewmodel.dart';

class LoginBody extends StatelessWidget {
  final LoginScreenState _state;

  LoginBody(this._state);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewmodel>.reactive(
      builder: (context, viewmodel, _) => Scaffold(
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
                            height: 10.0,
                          ),
                          ...buildLoginTextFields(_state),
                          LoginRegisterText(),
                          LoginButton(viewmodel: viewmodel, state: _state),
                          SizedBox(
                            height: 10.0,
                          ),
                        ]))
              ]))),
      viewModelBuilder: () => LoginViewmodel(),
    );
  }
}
