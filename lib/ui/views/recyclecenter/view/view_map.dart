// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_green_app/model/RecycleCenter.dart';
import 'package:my_green_app/ui/views/recyclecenter/recyclecenter_screen.dart';
import 'package:my_green_app/ui/views/recyclecenter/recyclecenter_screenstate.dart';
import 'package:my_green_app/ui/views/recyclecenter/recyclecenter_viewmodel.dart';
import 'package:my_green_app/constants/routes_path.dart' as routes;



class ViewMap extends StatefulWidget {

  static Set<Marker> markers=Set();
  final RecycleCenterViewmodel viewmodel;
  final RecycleCenterScreenfulState state;
  final RecycleCenter model;
  ViewMap(
      {required this.viewmodel, required this.state, required this.model});

  @override
  State<ViewMap> createState() => _ViewMapState();
}

class _ViewMapState extends State<ViewMap> {
  Completer<GoogleMapController> _controller=Completer();
  @override
  void initState() {
    super.initState();
    if(RecycleCenterViewmodel.viewAction==true) {
      setState(() {
      ViewMap.markers.add(Marker(
        markerId: MarkerId(widget.model.name),
        position: LatLng(widget.model.lat,widget.model.lon),
        infoWindow: InfoWindow(
          title: widget.model.name,
          snippet: widget.model.address,
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
    }
  }

  @override
  Widget build(BuildContext context)
  { 
      return Stack(
          children: [
            SizedBox(
              height: MediaQuery. of(context). size. height,
              width: MediaQuery. of(context). size. width,
              child: GoogleMap( 
                initialCameraPosition: CameraPosition(
                  target: LatLng(widget.model.lat,widget.model.lon),
                  zoom: 13,
                ),
                mapType: MapType.normal,
                markers: ViewMap.markers,
                onMapCreated: (GoogleMapController controller)
                {
                  if (!_controller.isCompleted) {
                    _controller.complete(controller);
                  }
                },
              ),
            ),
            CloseButton(
              onPressed: () {
                widget.state.onCloseView(widget.viewmodel);
                Navigator.of(context).pushNamed(routes.rcRoute);
              },
            )
          ],
        
      );
  }
}
