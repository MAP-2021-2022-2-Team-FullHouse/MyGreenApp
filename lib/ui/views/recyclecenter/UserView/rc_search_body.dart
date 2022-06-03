import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:my_green_app/model/RecycleCenter.dart';
import 'package:my_green_app/ui/views/recyclecenter/CreateRecycleCenter/create_recycle_center_viewmodel.dart';
import 'package:my_green_app/ui/views/recyclecenter/UserView/rc_appbar.dart';
import 'package:my_green_app/ui/views/recyclecenter/UserView/rc_list.dart';
import 'package:my_green_app/ui/views/recyclecenter/UserView/rc_viewmodel.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:stacked/stacked.dart';

import '../../map/MapViewModel.dart';
import '../../map/mapScreen.dart';
import 'rc_screenstate.dart';

class RCSearchBody extends StatelessWidget {
  final String queryString;
  final RCScreenfulState state;
  const RCSearchBody(this.state, this.queryString, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   
    return ViewModelBuilder<RCViewmodel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: const RCAppBar(),
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
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(rcInOrder[index].email),
                                      Text(rcInOrder[index].phone),
                                      Text(rcInOrder[index].address),
                                      ButtonBar(
                                        children: <Widget>[
                                          ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.green),
                                              foregroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.white),
                                            ),
                                            onPressed: () {
                                              MapViewModel.openMap(
                                                  rcInOrder[index].lat,
                                                  rcInOrder[index].lon);
                                            },
                                            child: const Text('Direction'),
                                          ),
                                          ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.green),
                                              foregroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.white),
                                            ),
                                            onPressed: () {
                                              // ignore: deprecated_member_use
                                              UrlLauncher.launch(
                                                  'tel:+${rcInOrder[index].phone}');
                                            },
                                            child: const Text('Call'),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 350,
                                        child: Divider(
                                          thickness: 2,
                                        ),
                                      ),
                                    ],
                                  ),
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
