import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_green_app/ui/views/recyclecenter/recyclecenter_button.dart';
import 'package:my_green_app/ui/views/recyclecenter/recyclecenter_screenstate.dart';

import '../../../model/RecycleCenter.dart';
import 'package:my_green_app/ui/views/recyclecenter/recyclecenter_viewmodel.dart'
    as rcviewmodel;

Widget buildRC(RecycleCenter rc) => ListTile(
      leading: CircleAvatar(child: Text(rc.name)),
      title: Text(rc.name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(rc.email),
          Text(rc.phone),
          Text(rc.address),
          Container(child: Row()),
          RCListButton(
            viewmodel: rcviewmodel.RecycleCenterViewmodel(),
            model: rc,
            state: RecycleCenterScreenfulState(),
          )
        ],
      ),
    );
