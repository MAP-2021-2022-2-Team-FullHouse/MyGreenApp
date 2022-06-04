import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_green_app/model/user.dart';
import 'package:my_green_app/ui/views/profile/profile_screen.dart' as state;
import 'package:my_green_app/ui/views/recyclecenter/recyclecenter_button.dart';

import '../../../model/RecycleCenter.dart';
import 'package:my_green_app/ui/views/profile/profile_viewmodel.dart'
    as profileviewmodel;

Widget buildDetails(DocumentSnapshot<Map<String, dynamic>> user) => ListTile(
      leading: CircleAvatar(child: Text(user['name'])),
      title: Text(user['name']),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(user['email']),
          Text(user['phone']),
          Text(user['address']),
          Container(child: Row()),
          /* RCListButton(
              viewmodel: profileviewmodel.ProfileViewmodel(currUser),
              state: state.ProfileScreenState(),
              model: currUser) */
        ],
      ),
    );
