// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_green_app/model/RecycleCenter.dart';
import 'package:my_green_app/ui/views/recyclecenter/recyclecenter_screen.dart';
import 'package:my_green_app/ui/views/recyclecenter/recyclecenter_viewmodel.dart';

  Completer<GoogleMapController> _controller=Completer();
  Set<Marker> markers=Set();

  Widget buildViewRC(context, viewmodel, RecycleCenter rc)
  { 
    if(rc.email.isNotEmpty)
    {
      return Stack(
          children: [
            SizedBox(
              height: MediaQuery. of(context). size. height,
              width: MediaQuery. of(context). size. width,
              child: GoogleMap( 
                initialCameraPosition: CameraPosition(
                  target: LatLng(rc.lat,rc.lon), //initial lon lat (UTM)
                  zoom: 13,
                ),
                mapType: MapType.normal,
                markers: markers,
                onMapCreated: (GoogleMapController controller)
                {
                  if (!_controller.isCompleted) {
                    _controller.complete(controller);
                  }
                },
              ),
            ),
            CloseButton(
              onPressed: () => {
                viewmodel.closeViewRC(context)
              },
            )
          ],
        
      );
    }
    else
    {
      return SizedBox(
        height: 10,
        child: Text("Error occurs in getting recycle center"),
      );
    }
    
  }
    


