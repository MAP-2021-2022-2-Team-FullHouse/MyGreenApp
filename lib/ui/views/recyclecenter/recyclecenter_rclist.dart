import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_green_app/ui/views/recyclecenter/recyclecenter_button.dart';
import 'package:my_green_app/ui/views/recyclecenter/recyclecenter_screenstate.dart';

import '../../../model/RecycleCenter.dart';
import 'package:my_green_app/ui/views/recyclecenter/recyclecenter_viewmodel.dart'
  as rcviewmodel;

 RecycleCenterScreenfulState state=new RecycleCenterScreenfulState();

Widget buildRC(RecycleCenter rc) => ListTile(
      leading: CircleAvatar(
        child: FutureBuilder(
      future: state.getImgUrl("files/"+rc.image),
      builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
        bool error = snapshot.data == null;
        return Container(
            child: buildImage(snapshot.data),
          );
      },
    ),
      ),
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

    Widget buildImage(String? data) {
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: NetworkImage(data.toString()),
          fit: BoxFit.cover,
          width: 128,
          height: 128,
          child: InkWell(/* onTap: onClicked */),
        ),
      ),
    );
  }
