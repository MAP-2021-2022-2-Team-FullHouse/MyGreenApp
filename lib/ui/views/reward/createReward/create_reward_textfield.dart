import 'package:flutter/material.dart';
import 'create_reward_screen.dart';
import 'widget/create_textfield.dart';


List<Widget> buildCreateTextFields(CreateRewardScreenState state) => [
       CreateTextField(
        controller: state.titleController,
        hintText: "Tupperware",
        labelText: "Reward Title: ",
      ),
      const SizedBox(
        height: 5.0,
      ),
      CreateTextField(
        controller: state.descriptionController,
        hintText: "1 litre",
        labelText: "Description: ",
      ),
      const SizedBox(
        height: 5.0,
      ),
      CreateTextField(
        controller: state.quantityController,
        hintText: "20",
        labelText: "Quantity:",
        enableSuggestions: false,
        autoCorrect: false,
        keyboard: TextInputType.number,
      ),
      const SizedBox(
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
      const SizedBox(
        height: 5.0,
      ),
     
      
      
    ];
