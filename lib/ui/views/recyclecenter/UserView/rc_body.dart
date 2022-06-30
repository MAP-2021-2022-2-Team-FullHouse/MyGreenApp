import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:my_green_app/model/RecycleCenter.dart';
import 'package:my_green_app/ui/views/recyclecenter/UserView/rc_list.dart';
import 'package:my_green_app/ui/views/recyclecenter/UserView/rc_viewmodel.dart';
import 'package:stacked/stacked.dart';

import '../../map/mapScreen.dart';
import 'rc_screenstate.dart';
import 'rc_search_body.dart';

class RCBody extends StatelessWidget {
  final RCScreenfulState _state;
  final Position p;
  const RCBody(this._state,this.p, {Key? key}) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
   
    
    TextEditingController searchController = TextEditingController();
    return ViewModelBuilder<RCViewmodel>.reactive(
      builder: (context, model, child) => Scaffold(
         body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              SizedBox(
                //margin: EdgeInsets.all(20),
                //color: Colors.teal,
                width: 350,
                height: 100,
                child: Column(children: [
                  Row(
                   
                    children: [
                     SizedBox(
                      width:300,
                       child: TextField(

                    controller: searchController,
                    decoration: const InputDecoration(
                          // prefixIcon: Icon(Icons.search), 
                          hintText: 'Search...'),
                  ),
                     ),
                     IconButton(
                      icon:Icon(Icons.search),
                     onPressed:(){
                      
                      Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => RCSearchBody(_state, searchController.text, p),
                            ));

                     }),
                  ],),
                 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      
                     
                      ElevatedButton.icon(
                          label:Text("Around me", style:TextStyle(color:Colors.white,)),
                                    icon:Icon(Icons.map, color:Colors.white),
                                   style: ElevatedButton.styleFrom(
                                       primary: Color.fromARGB(255, 229, 15, 0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => MapScreen(),
                          ));
                        },
                      ),
                    ],
                  ),
                ]),
              ),
              const SizedBox(
                width: 350,
                child: Divider(
                  thickness: 2,
                ),
              ),
              const SizedBox(height: 10),
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
                       

                        double distance=RCViewmodel.calculateDistance(
                            rc.lat, rc.lon, p.latitude, p.longitude);
                            print("aaaaaaaaa${p.latitude}");
                            rlist.add({
                          "Recycle Center": recyclecenters[i],
                          "Distance": distance
                        });

                              rlist = rlist 
                        ..sort(
                            (a, b) => a['Distance'].compareTo(b['Distance']));
                        // p=GPSService.abc();
                 for (int j = 0; j < rlist.length; j++) {
                
                        rcInOrder.add(rlist[j]["Recycle Center"]);

                      }

                        }
                      //print(" qqqqqqqqqqqq  "+rcInOrder[0].name);
                     
                        return ListView(
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          children: rlist.map(RCList).toList(),
                        );
                      

                    
                    } else {
                      return const Center(child: Text('No data found'));
                    }
                  })
            ],
          ),
         )
      ),
      viewModelBuilder: () => RCViewmodel(),
    );
  }
}
