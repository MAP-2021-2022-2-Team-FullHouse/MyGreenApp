import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_green_app/ui/views/recyclecenter/UserView/rc_screenstate.dart';
import 'package:my_green_app/ui/views/recyclecenter/recyclecenter_button.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:my_green_app/ui/views/recyclecenter/UserView/rc_viewmodel.dart'
    as userRCviewmodel;
import 'package:my_green_app/ui/views/recyclecenter/recyclecenter_viewmodel.dart'
    as rcviewmodel;

import '../../../../model/RecycleCenter.dart';
import '../../map/MapViewModel.dart';

Widget RCList(Map<String, dynamic> r) 
{ 
  RCScreenfulState st=new RCScreenfulState();
  RecycleCenter rc=r["Recycle Center"];
  return SingleChildScrollView(
  child:Column(
    children: [ListTile(
      leading: CircleAvatar(
        child: FutureBuilder(
      future: st.getImgUrl("recycleCenter/"+rc.image),
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
          
            Text(rc.address),
            Text(r['Distance'].toStringAsFixed(2)+" km", style:TextStyle(fontWeight: FontWeight.bold, color: Colors.red, ),),
            Row(
             
              children: <Widget>[
                                ElevatedButton.icon(
                          
                                    label:Text("Appointment", style:TextStyle(color:Colors.white,)),
                                    icon:Icon(Icons.edit, color:Colors.white),
                                   style: ElevatedButton.styleFrom(
                                       primary: Color.fromARGB(255, 0, 229, 187),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    onPressed: () {
                                      userRCviewmodel.RCViewmodel.navigateAppointment(rc.email);
                                    },
                                    
                                  ),
                                  ElevatedButton(
                                    child:Icon(Icons.directions, color:Colors.white),
                                    style: ElevatedButton.styleFrom(
                                      primary: Color.fromARGB(255, 7, 214, 255),
                                        shape: CircleBorder(),
                                        padding: EdgeInsets.all(10),
                                      ),
                                    onPressed: () {
                                      MapViewModel.openMap(
                                          rc.lat,
                                          rc.lon);
                                    },
                                    
                                  ),
                                  ElevatedButton(
                                    child:Icon(Icons.phone, color:Colors.white),
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.amber,
                                        shape: CircleBorder(),
                                        padding: EdgeInsets.all(10),
                                      ),
                                    onPressed: () {
                                      UrlLauncher.launch(
                                          'tel:+${rc.phone}');
                                    },
                                    // label: Text('Call'),
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
),]
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
