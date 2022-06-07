import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_green_app/ui/views/recyclecenter/UserView/rc_screenstate.dart';
import 'package:my_green_app/ui/views/recyclecenter/recyclecenter_button.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

import 'package:my_green_app/ui/views/recyclecenter/recyclecenter_viewmodel.dart'
    as rcviewmodel;

import '../../../../model/RecycleCenter.dart';
import '../../map/MapViewModel.dart';

Widget RCList(RecycleCenter rc) 
{ 
  RCScreenfulState st=new RCScreenfulState();
  return SingleChildScrollView(
  child:Expanded(
    child: ListTile(
      leading: CircleAvatar(
        child: FutureBuilder(
      future: st.getImgUrl("files/"+rc.image),
      builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
        bool error = snapshot.data == null;
        return Container(
            child: buildImage(snapshot.data),
          );
      },
    ),
      ),
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
}
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
