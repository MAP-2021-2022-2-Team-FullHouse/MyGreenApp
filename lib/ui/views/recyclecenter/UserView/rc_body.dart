import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:my_green_app/model/RecycleCenter.dart';
import 'package:my_green_app/services/recycleCenter/GPSService.dart';
import 'package:my_green_app/ui/views/recyclecenter/CreateRecycleCenter/CreateRecycleCenter_ViewModel.dart';
import 'package:my_green_app/ui/views/recyclecenter/UserView/rc_list.dart';
import 'package:my_green_app/ui/views/recyclecenter/UserView/rc_viewmodel.dart';
import 'package:my_green_app/ui/views/recyclecenter/recyclecenter_rclist.dart';
import 'package:stacked/stacked.dart';

import '../../map/mapScreen.dart';
import 'rc_screenstate.dart';


class RCBody extends StatelessWidget {
  final RCScreenfulState _state;
  const RCBody(this._state);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
    return ViewModelBuilder<RCViewmodel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height:10),
              Container(
          //margin: EdgeInsets.all(20),
          //color: Colors.teal,
          width: 350,
          height: 50,
          child: Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              style:ElevatedButton.styleFrom(
                primary: Colors.green,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                textStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold)),
              child: Text("Open Map"),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => MapScreen(),
            ));

             },
            ),
          ),
        ),
        SizedBox(
                              width: 350,
                              child: Divider(
                                thickness: 2,
                              ),
                            ),
              SizedBox(height:10),
              StreamBuilder<List<RecycleCenter>>(
                  stream: model.getRCList(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text('Something went wrong'));
                    }
                    if (snapshot.hasData) {
                      final recyclecenters = snapshot.data!;
                      List<RecycleCenter> rlist=[];
                      for(int i=0; i<recyclecenters.length; i++){
                        RecycleCenter rc=recyclecenters[i];
                        late Position p;
                       CreateRecycleCenter_ViewModel.getPosition().then((value) {
                          p = value;
                       });
                        // p=GPSService.abc();
                        if(RCViewmodel.calculateDistance(rc.lat, rc.lon,1.48576 , 103.6488)<5){
                            rlist.add(recyclecenters[i]);
                        }
                      }
                      return ListView(
                        physics: NeverScrollableScrollPhysics(),
                        children: rlist.map(RCList).toList(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                      );
                    } else {
                      return Center(child: Text('No data found'));
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
