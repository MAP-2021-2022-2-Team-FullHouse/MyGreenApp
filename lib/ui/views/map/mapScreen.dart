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

  
  Set<Marker> markers = Set();
static late CameraPosition  cam;
  

  void initState() {
    super.initState();
    MapViewModel.fetchRecycleCenters();
    markers=MapViewModel.markers;
    MapViewModel.currentCameraPosition();
    print(cam.toString());
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
            
            child: GoogleMap(
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              mapType: MapType.normal,
              markers: Set.from(markers),
              initialCameraPosition: cam,
              onMapCreated: (controller) => mapController = controller,
              //       onMapCreated: (GoogleMapController controller) {
              //       _controller.complete(controller);
              // },
            ),
          );
        }),
        
      ]),
    );
  }

  void dispose() {
    mapController.dispose();
    super.dispose();
  }
}
