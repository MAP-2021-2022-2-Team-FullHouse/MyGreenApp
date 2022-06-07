import 'package:flutter/material.dart';

import 'login_screen.dart';
import 'widget/login_textfield.dart';

List<Widget> buildLoginTextFields(LoginScreenState state) => [
      LoginTextField(
        controller: state.usernameController,
        hintText: "ali@gmail.com",
        iconName: Icons.account_circle_outlined,
      ),
      SizedBox(
        height: 5.0,
      ),
      LoginTextField(
        controller: state.passwordController,
        hintText: "password",
        enableSuggestions: false,
        autoCorrect: false,
        obscureText: true,
        iconName: Icons.key,
      ),
      SizedBox(
        height: 5.0,
      ),
    ];
