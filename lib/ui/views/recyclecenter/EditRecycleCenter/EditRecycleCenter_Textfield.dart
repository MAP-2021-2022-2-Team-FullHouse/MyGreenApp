import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:my_green_app/ui/views/profile/widget/button.dart';
import 'EditRecycleCenter_Screen.dart';
import 'widget/edit_textfield.dart';
import 'package:my_green_app/model/RecycleCenter.dart';
import 'EditRecycleCenter_ViewModel.dart';

List<Widget> buildEditTextFields(
        EditRecycleCenterScreenState state, RecycleCenter rc) =>
    [
      EditTextField(
        controller: state.nameController..text = rc.name,
        labelText: "Full Name: ",
      ),
      SizedBox(
        height: 5.0,
      ),
      EditTextField(
        controller: state.phoneField..text = rc.phone,
        labelText: "Phone Number: ",
      ),
      SizedBox(
        height: 5.0,
      ),
      EditTextField(
        controller: state.emailField..text = rc.email,
        labelText: "Email: ",
        enableSuggestions: false,
        autoCorrect: false,
        keyboard: TextInputType.emailAddress,
      ),
      SizedBox(
        height: 5.0,
      ),
      EditTextField(
        controller: state.passwordController..text = rc.password,
        labelText: "Password: ",
        enableSuggestions: false,
        autoCorrect: false,
        obscureText: true,
      ),
      SizedBox(
        height: 68.0,
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
      EditTextField(
        controller: state.addrsField..text = rc.address,
        labelText: "Address: ",
      ),
      SizedBox(
        height: 5.0,
      ),
      EditTextField(
        controller: state.latField..text = rc.lat.toString(),
        labelText: "Latitude: ",
        keyboard: TextInputType.number,
      ),
      SizedBox(
        height: 5.0,
      ),
      EditTextField(
        controller: state.lonField..text = rc.lon.toString(),
        labelText: "Longitude: ",
        keyboard: TextInputType.number,
      ),
      SizedBox(
        height: 70.0,
      ),
      ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Color.fromRGBO(29, 194, 95, 1),
            minimumSize: Size.fromHeight(50),
          ),
          onPressed: () async {
            state.latField.text = "1.482641";
            state.lonField.text = "103.644991";
            Position p = await EditRecycleCenter_ViewModel.getPosition();
            String lat = p.latitude.toString();
            String lon = p.longitude.toString();
            state.latField.text = lat;
            state.lonField.text = lon;
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.map, size: 28),
              SizedBox(width: 16),
              Text(
                "Get Location",
                style: TextStyle(fontSize: 22, color: Colors.white),
              ),
            ],
          )),
      EditTextField(
        controller: state.fileField..text = rc.image,
        labelText: "Image File: ",
      ),
      SizedBox(
        height: 70.0,
      ),
      ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Color.fromRGBO(29, 194, 95, 1),
            minimumSize: Size.fromHeight(50),
          ),
          onPressed: () async {
            EditRecycleCenter_ViewModel.selectFile(state);
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.attach_file, size: 28),
              SizedBox(width: 16),
              Text(
                "Select Image",
                style: TextStyle(fontSize: 22, color: Colors.white),
              ),
            ],
          )),
    ];
