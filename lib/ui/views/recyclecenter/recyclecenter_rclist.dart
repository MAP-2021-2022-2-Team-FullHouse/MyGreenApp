import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../model/RecycleCenter.dart';

Widget buildRC(RecycleCenter rc)=>ListTile(
        leading: CircleAvatar(child: Text(rc.name)),
        title: Text(rc.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(rc.email),
              Text(rc.phone),
              Text(rc.address),
              Container( child: Row()),
              Container(
                  child: Row(
                children: <Widget>[
                  FlatButton(
                    child: Text("View Details"),
                    onPressed: () {},
                  ),
                  FlatButton(
                    child: Text("Edit"),
                    onPressed: () {},
                  ),
                  FlatButton(
                    child: Text("Delete"),
                    onPressed: () {},
                  ),
                        
                      ],
                    ))
                  ],
                ),
      );