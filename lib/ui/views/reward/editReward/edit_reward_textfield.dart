import 'package:flutter/material.dart';
import 'package:my_green_app/model/Reward.dart';
import 'package:my_green_app/ui/views/reward/editReward/widget/edit_pic.dart';
import 'edit_reward.dart';



List<Widget> buildEditRewardTextFields(
        EditRewardScreenState state, Reward rc) =>
    [
      EditTextField(
        controller: state.titleController..text = rc.title,
        labelText: "Title: ",
      ),
      const SizedBox(
        height: 5.0,
      ),
      EditTextField(
        controller: state.descriptionController..text = rc.description,
        labelText: "Description: ",
      ),
      const SizedBox(
        height: 5.0,
      ),
      EditTextField(
        controller: state.quantityController..text = "${rc.quantity}",
        labelText: "Quantity:",
        keyboard: TextInputType.number,
      ),
      const SizedBox(
        height: 5.0,
      ),
      EditTextField(
        controller: state.pointController..text ="${ rc.point}",
        labelText: "Points to redeem:",  
      ),
      const SizedBox(
        height: 68.0,
      ),
       EditPicture(state: state,reward:rc),
        const SizedBox(
        height: 68.0,
      ),
    ];
