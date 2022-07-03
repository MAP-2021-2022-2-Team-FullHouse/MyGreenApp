import 'package:flutter/material.dart';
import 'package:my_green_app/ui/views/reset/reset_text.dart';
import 'package:my_green_app/ui/views/reset/reset_textfields.dart';
import 'package:my_green_app/ui/views/reset/reset_button.dart';
import 'package:stacked/stacked.dart';
import 'reset_button.dart';
import 'reset_screen.dart';
import 'reset_viewmodel.dart';

class ResetBody extends StatelessWidget {
  final ResetScreenState _state;

  ResetBody(this._state);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ResetViewmodel>.reactive(
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
              child: SingleChildScrollView(
                  child: Column(children: [
                Container(
                    margin: const EdgeInsets.fromLTRB(20, 100, 20, 20),
                    child: Image.asset('assets/logo.png',
                        height: 150, width: 250)),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 5, 0, 40),
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'Open Sans',
                        fontSize: 40),
                  ),
                ),
                Container(
                    margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                    height: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
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
                    padding: const EdgeInsets.fromLTRB(30, 20, 20, 0),
                    child: Column(children: [
                      ResetText(),
                      ...buildResetTextFields(_state),
                      ResetButton(viewmodel: viewmodel, state: _state),
                    ]))
              ])))),
      viewModelBuilder: () => ResetViewmodel(),
    );
  }
}
