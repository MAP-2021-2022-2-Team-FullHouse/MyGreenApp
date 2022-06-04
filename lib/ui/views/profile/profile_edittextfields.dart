import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_green_app/ui/views/profile/profile_screen.dart';
import 'package:my_green_app/ui/views/profile/widget/profile_textField.dart';

final usernameController = TextEditingController();
final passwordController = TextEditingController();
final phoneField = TextEditingController();
final addrsField = TextEditingController();

List<Widget> buildProfileTextFields(ProfileScreenState state,
        DocumentSnapshot<Map<String, dynamic>> documentSnapshot) =>
    [
      ProfileTextField(
        controller: phoneField,
        hintText: documentSnapshot['phone'],
        labelText: "Phone Number: ",
      ),
      SizedBox(
        height: 5.0,
      ),
      ProfileTextField(
        controller: usernameController,
        hintText: documentSnapshot['name'],
        labelText: "Full Name: ",
      ),
      SizedBox(
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
      ProfileTextField(
        controller: addrsField,
        hintText: documentSnapshot['address'],
        labelText: "Address: ",
      ),
      SizedBox(
        height: 5.0,
      ),
    ];
