import 'package:flutter/material.dart';
import 'package:my_green_app/services/RecycleCenter/GPSService.dart';
import 'CreateReward_Screen.dart';
import 'widget/create_textfield.dart';
import 'package:geolocator/geolocator.dart';


List<Widget> buildCreateTextFields(CreateRewardScreenState state) => [
       CreateTextField(
        controller: state.titleController,
        hintText: "Tupperware",
        labelText: "Reward Title: ",
      ),
      SizedBox(
        height: 5.0,
      ),
      CreateTextField(
        controller: state.descriptionController,
        hintText: "1 litre",
        labelText: "Description: ",
      ),
      SizedBox(
        height: 5.0,
      ),
      CreateTextField(
        controller: state.quantityController,
        hintText: "20",
        labelText: "Quantity: ",
        enableSuggestions: false,
        autoCorrect: false,
        keyboard: TextInputType.number,
      ),
      SizedBox(
        height: 5.0,
      ),
      
      CreateTextField(
        controller: state.pointController,
        hintText: "20",
        labelText: "Points to Redeem:",
        enableSuggestions: false,
        autoCorrect: false,
        obscureText: true,
      ),
      SizedBox(
        height: 5.0,
      ),
     
      
      
    ];
