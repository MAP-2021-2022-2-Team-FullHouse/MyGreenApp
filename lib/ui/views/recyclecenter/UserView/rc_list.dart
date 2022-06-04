import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_green_app/ui/views/recyclecenter/recyclecenter_button.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

import 'package:my_green_app/ui/views/recyclecenter/recyclecenter_viewmodel.dart'
    as rcviewmodel;

import '../../../../model/RecycleCenter.dart';
import '../../map/MapViewModel.dart';

Widget RCList(RecycleCenter rc) => SingleChildScrollView(
  child:Expanded(
    child: ListTile(
        title: Text(rc.name,style:TextStyle( fontSize: 20),),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            
            Text(rc.email),
            Text(rc.phone),
            Text(rc.address),
             ButtonBar(children: <Widget>[
                                  ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(Colors.green),
                                      foregroundColor:
                                          MaterialStateProperty.all(Colors.white),
                                    ),
                                    onPressed: () {
                                      MapViewModel.openMap(
                                          rc.lat,
                                          rc.lon);
                                    },
                                    child: Text('Direction'),
                                  ),
                                  ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(Colors.green),
                                      foregroundColor:
                                          MaterialStateProperty.all(Colors.white),
                                    ),
                                    onPressed: () {
                                      UrlLauncher.launch(
                                          'tel:+${rc.phone}');
                                    },
                                    child: Text('Call'),
                                  ),
                     
            
          ],   
        ),
                              SizedBox(
                                width: 350,
                                child: Divider(
                                  thickness: 2,
                                ),
                              ),
                                   
        ]
        )
),
  )


);
