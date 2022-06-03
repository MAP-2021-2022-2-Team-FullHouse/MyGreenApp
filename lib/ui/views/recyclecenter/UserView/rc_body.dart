import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:my_green_app/model/RecycleCenter.dart';
import 'package:my_green_app/ui/views/recyclecenter/CreateRecycleCenter/create_recycle_center_viewmodel.dart';
import 'package:my_green_app/ui/views/recyclecenter/UserView/rc_list.dart';
import 'package:my_green_app/ui/views/recyclecenter/UserView/rc_viewmodel.dart';
import 'package:stacked/stacked.dart';

import '../../map/mapScreen.dart';
import 'rc_screenstate.dart';
import 'rc_search_body.dart';

class RCBody extends StatelessWidget {
  final RCScreenfulState _state;
  const RCBody(this._state, {Key? key}) : super(key: key);

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
                  TextField(
                    controller: searchController,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.search), hintText: 'Search...'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.green,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              textStyle: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          child: const Text("Search"),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => RCSearchBody(_state, searchController.text),
                            ));
                          }),
                      const SizedBox(width: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            textStyle: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        child: const Text("Open Map"),
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
                        // ignore: unused_local_variable
                        late Position p;
                        CreateRecycleCenter_ViewModel.getPosition()
                            .then((value) {
                          p = value;
                        });
                        // p=GPSService.abc();
                        double distance = RCViewmodel.calculateDistance(
                            rc.lat, rc.lon, 1.48576, 103.6488);

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
                     
                        return ListView(
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          children: rcInOrder.map(RCList).toList(),
                        );
                      

                    
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
