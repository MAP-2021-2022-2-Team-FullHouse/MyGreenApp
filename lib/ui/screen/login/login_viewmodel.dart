// @dart=2.9
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mygreenapp/app/app.dart';
import 'package:mygreenapp/app/routes.dart';
import 'package:mygreenapp/app/service_locator.dart';
import 'package:mygreenapp/model/user.dart';
import 'package:mygreenapp/services/dialog/dialog_service.dart';
import 'package:mygreenapp/services/navigation_service.dart';
import 'package:mygreenapp/ui/screen/home/home_screen.dart';
import 'package:mygreenapp/ui/screen/login/login_body.dart';
import 'package:mygreenapp/ui/screen/login/login_screen.dart';

import '../../../model/user.dart';
import '../viewmodel.dart';
import '../../../services/user/user_repository.dart';

class LoginViewmodel extends Viewmodel {
  final UserRepository _userRepository = locator();
  final _navigationService = locator<NavigationService>();
  DialogService _dialogService = locator<DialogService>();
  BuildContext context;

  LoginViewmodel() {
    _userRepository.addListener(() {
      notifyListeners();
    });
  }

  User get user => _userRepository.user.copyWith();
  String _errorMessage;
  String get errorMessage => _errorMessage;
  set errorMessage(value) => update(() => _errorMessage = value);

  Future signIn({@required String email, @required String password}) async {
    dynamic result =
        await _userRepository.signIn(email: email, password: password);
    if (_userRepository.user != null) {
      _errorMessage = null;
      print(_userRepository.user.uid);
      //var dialogResult = await _dialogService.showDialog();
      //_navigationService.navigateTo('/home');
      //showAlertDialog(this.context, 'Welcome', result);
    } else {
      //showAlertDialog(context, _errorMessage);
      _errorMessage = _userRepository.error;
      return _errorMessage;
    }
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
