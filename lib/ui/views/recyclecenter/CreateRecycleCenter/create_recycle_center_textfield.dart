import 'package:flutter/material.dart';
import 'create_recycle_center.dart';


List<Widget> buildCreateTextFields(CreateRecycleCenterScreenState state) => [
       CreateTextField(
        controller: state.nameController,
        hintText: "Lala Recycle Center",
        labelText: "Full Name: ",
      ),
      const SizedBox(
        height: 5.0,
      ),
      CreateTextField(
        controller: state.phoneField,
        hintText: "+60123456789",
        labelText: "Phone Number: ",
      ),
      const SizedBox(
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
      const SizedBox(
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
      const SizedBox(
        height: 5.0,
      ),
      const Align(
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
      const SizedBox(
        height: 5.0,
      ),
      
      
    ];
