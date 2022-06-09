import 'package:flutter/material.dart';
import 'package:my_green_app/model/RewardUnit.dart';
import 'edit_tracking_no.dart';



List<Widget> buildEditTrackingNoTextFields(
        EditTrackingNoScreenState state, RewardUnit rc) =>
    [
      EditTextField(
        controller: state.trackingnoController..text = rc.trackingNo,
        labelText: "Tracking No: ",
      ),
      
      
    ];
