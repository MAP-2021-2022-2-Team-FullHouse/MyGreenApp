import 'package:flutter/material.dart';
import 'package:my_green_app/services/RecycleCenter/GPSService.dart';
import 'CreateRecycleCenter_Screen.dart';
import 'widget/create_textfield.dart';
import 'package:geolocator/geolocator.dart';


List<Widget> buildCreateTextFields(CreateRecycleCenterScreenState state) => [
       CreateTextField(
        controller: state.nameController,
        hintText: "Lala Recycle Center",
        labelText: "Full Name: ",
      ),
      SizedBox(
        height: 5.0,
      ),
      CreateTextField(
        controller: state.phoneField,
        hintText: "+60123456789",
        labelText: "Phone Number: ",
      ),
      SizedBox(
        height: 5.0,
      ),
      CreateTextField(
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
      
      CreateTextField(
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
      CreateTextField(
        controller: state.addrsField,
        hintText: "No.,Jalan,Taman",
        labelText: "Address: ",
      ),
      SizedBox(
        height: 5.0,
      ),
      
      
    ];
