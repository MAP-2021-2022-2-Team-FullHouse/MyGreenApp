import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:my_green_app/model/RecycleCenter.dart';
import 'package:my_green_app/ui/views/recyclecenter/CreateRecycleCenter/create_recycle_center_viewmodel.dart';
import 'package:my_green_app/ui/views/recyclecenter/UserView/rc_appbar.dart';
import 'package:my_green_app/ui/views/recyclecenter/UserView/rc_list.dart';
import 'package:my_green_app/ui/views/recyclecenter/UserView/rc_viewmodel.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:stacked/stacked.dart';
import 'package:my_green_app/ui/views/recyclecenter/UserView/rc_viewmodel.dart'
    as userRCviewmodel;

import '../../map/MapViewModel.dart';
import '../../map/mapScreen.dart';
import 'rc_screenstate.dart';

class RCSearchBody extends StatelessWidget {
  final String queryString;
  final RCScreenfulState state;
    final Position p;
   
  const RCSearchBody(this.state, this.queryString, this.p,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   
    return ViewModelBuilder<RCViewmodel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
        elevation: 10,
        toolbarHeight: 70,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(
          'Nearby Recycle Center',
          style: TextStyle(color: Colors.black.withOpacity(1.0)),
        ),
        // backgroundColor: Colors.green,
      ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              StreamBuilder<List<RecycleCenter>>(
                  stream: model.getRCList(),
                  builder: (context, snapshot) {

                    if (snapshot.hasError) {
                      return const Center(child: Text('Something went wrong'));
                    }
                    if (snapshot.hasData) {
                     
                      final recyclecenters = snapshot.data!;
                     
                      List<Map<String, dynamic>> rlist = [];
                      List<RecycleCenter> rcInOrder = [];
                      for (int i = 0; i < recyclecenters.length; i++) {
                        RecycleCenter rc = recyclecenters[i];
                        // ignore: unused_local_variable
                       
                        // p=GPSService.abc();
                        double distance = RCViewmodel.calculateDistance(
                            rc.lat, rc.lon, p.latitude, p.longitude);

                        rlist.add({
                          "Recycle Center": recyclecenters[i],
                          "Distance": distance
                        });
                      }
                      rlist = rlist
                        ..sort(
                            (a, b) => a['Distance'].compareTo(b['Distance']));
                      for (int j = 0; j < rlist.length; j++) {
                        rcInOrder.add(rlist[j]["Recycle Center"]);
                      }
                      
                      if (queryString.isNotEmpty) {
                       
                        return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: rcInOrder.length,
                            itemBuilder: (context, index) {
                              if (queryString.isNotEmpty &&
                                  rcInOrder[index]
                                      .name
                                      .toLowerCase()
                                      .contains(queryString.toLowerCase())) {
                                        
                                return ListTile(
                                  leading: CircleAvatar(
                                    child: FutureBuilder(
                                      future: state.getImgUrl(
                                          "recycleCenter/${rcInOrder[index].image}"),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<String?> snapshot) {
                                        return Container(
                                          child: buildImage(snapshot.data),
                                        );
                                      },
                                    ),
                                  ),
                                  title: Text(rcInOrder[index].name,
                                      style: const TextStyle(fontSize: 20)),
                                  subtitle:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
          
            Text(rcInOrder[index].address),
            Text(rlist[index]['Distance'].toStringAsFixed(2)+" km", style:TextStyle(fontWeight: FontWeight.bold, color: Colors.red, ),),
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
                                      userRCviewmodel.RCViewmodel.navigateAppointment(rcInOrder[index].email);
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
                                          rcInOrder[index].lat,
                                          rcInOrder[index].lon);
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
                                          'tel:+${rcInOrder[index].phone}');
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
                                );
                              }
                             
                              return Container();
                            });

                      } else {
                        // ignore: avoid_unnecessary_containers
                        return Container(
                       
                            child: const Align(
                          alignment:Alignment.center,
                          child: Text("No data found", style:TextStyle(fontSize: 28)),
                        ));
                      }
                     
                    } else {
                      return const Center(child: Text('No data found'));
                    }
                  })
            ],
          ),
        ),
      ),
      viewModelBuilder: () => RCViewmodel(),
    );
  }
}
