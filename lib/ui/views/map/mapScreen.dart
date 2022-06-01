import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_green_app/ui/views/map/MapViewModel.dart';
import 'package:my_green_app/model/RecycleCenter.dart';

import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class MapScreen extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (_) => MapScreen());
  @override
  State<MapScreen> createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  //final Completer<GoogleMapController> _controller = Completer();
  late GoogleMapController mapController;
  List centerList = [];
  List nearbyCenterList = [];
  Set<Marker> markers = Set();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(1.4823494048226642, 103.6470179124374),
    zoom: 14.4746,
  );

  void initState() {
    super.initState();
    fetchRecycleCenters();
  }

  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(
          'Nearest Recycle center',
          style: TextStyle(color: Colors.black.withOpacity(1.0)),
        ),
        backgroundColor: Colors.white,
      ),

      body: Stack(children: [
        LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return SizedBox(
            height: constraints.maxHeight * 0.8,
            child: GoogleMap(
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              mapType: MapType.normal,
              markers: Set.from(markers),
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (controller) => mapController = controller,
              //       onMapCreated: (GoogleMapController controller) {
              //       _controller.complete(controller);
              // },
            ),
          );
        }),
        DraggableScrollableSheet(
            initialChildSize: 0.2,
            minChildSize: 0.2,
            maxChildSize: 1.0,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                  color: Colors.white,
                  child: ListView.builder(
                    physics: ClampingScrollPhysics(),
                    controller: scrollController,
                    itemCount: centerList.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (index == 0) {
                        return Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(children: [
                            SizedBox(
                              width: 50,
                              child: Divider(
                                thickness: 5,
                              ),
                            ),
                            Text(
                                "Choose a recycle center or swipe up for more"),
                          ]),
                        );
                      }
                      return Card(
                          margin: EdgeInsets.zero,
                          elevation: 0,
                          child: Column(
                            children: <Widget>[
                              ListTile(
                                onTap: () {
                                  // dispose();
                                  // Navigator.of(context).push(MaterialPageRoute(builder:(context)=>MapDirection(name:centerList[index]['name'],address:centerList[index]['address'],phone:centerList[index]['phone'],lat:centerList[index]['lat'].toDouble(),lon:centerList[index]['lon'].toDouble()),));
                                },
                                title: Text(centerList[index]['name']),
                                subtitle:
                                    Text('${centerList[index]['address']}'),
                              ),
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
                                        centerList[index]['lat'].toDouble(),
                                        centerList[index]['lon'].toDouble());
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
                                        'tel:+${centerList[index]['phone']}');
                                  },
                                  child: Text('Call'),
                                ),
                                // FlatButton(
                                // color:Colors.amber,
                                // child: const Text('Call'),
                                // onPressed:(){},
                                // ),
                              ]),
                            ],
                          ));
                    },
                  ));
            }),
      ]),
    );
  }

  fetchRecycleCenters() async {
    dynamic resultant = await RecycleCenter.getCenterList();
    if (resultant == null) {
      print('unable to retrieve');
    } else {
      setState(() {
        centerList = resultant;
        for (int i = 0; i < centerList.length; i++) {
          markers.add(new Marker(
            markerId: MarkerId(centerList[i]['name']),
            infoWindow: InfoWindow(title: centerList[i]['name']),
            icon: BitmapDescriptor.defaultMarker,
            position: LatLng(centerList[i]['lat'].toDouble(),
                centerList[i]['lon'].toDouble()),
          ));
        }
      });
    }
  }
}
