import 'package:flutter/material.dart';

import 'register_screen.dart';
import 'widget/register_textfield.dart';

List<Widget> buildRegisterTextFields(RegisterScreenState state) => [
      RegisterTextField(
        controller: state.phoneField,
        hintText: "+60123456789",
        labelText: "Phone Number: ",
      ),
      SizedBox(
        height: 5.0,
      ),
      RegisterTextField(
        controller: state.usernameController,
        hintText: "Ali bin Abu",
        labelText: "Full Name: ",
      ),
      SizedBox(
        height: 5.0,
      ),
      RegisterTextField(
        controller: state.emailField,
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
        controller: state.passwordController,
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
        controller: state.addrsField,
        hintText: "No.,Jalan,Taman",
        labelText: "Address: ",
      ),
      SizedBox(
        height: 5.0,
      ),
      RegisterTextField(
          controller: state.codeField,
          hintText: "123456",
          labelText: "Postcode: "),
      SizedBox(
        height: 5.0,
      ),
    ];
