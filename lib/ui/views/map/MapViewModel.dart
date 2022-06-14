import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_green_app/services/recycleCenter/gps_service.dart';
import 'package:my_green_app/services/recycleCenter/recycleCenter_service_firebase.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'dart:math';
import 'package:my_green_app/model/RecycleCenter.dart';
import 'package:my_green_app/ui/views/map/mapScreen.dart';

class MapViewModel {
  static List rcenterList = [];
  static final Set<Marker> markers = Set();

  // Future getCenterList() async {
  //   // Get docs from collection reference
  //   QuerySnapshot querySnapshot = await _collectionRef.get();

  //   // Get data from docs and convert map to List
  //   centerList = querySnapshot.docs.map((doc) => doc.data()).toList();

  //   return centerList;
  // }

  static double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  static Future<void> openMap(
    double latitude,
    double longitude,
  ) async {
    String googleMapUrl =
        "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude";
    if (await UrlLauncher.canLaunch(googleMapUrl)) {
      await UrlLauncher.launch(googleMapUrl);
    } else {
      throw 'Could not apen map';
    }
  }

  static Future<void> currentCameraPosition() async {
    //for testing purpose
    double lat = 1.4823494048226642;
    double lon = 103.6470179124374;
    MapScreenState.cam = CameraPosition(
      target: LatLng(lat, lon),
      zoom: 14.4746,
    );

    //get realtime lat lon
    Position p = await GPSService.obtainLatLon();
    lat = p.latitude;
    lon = p.longitude;

    //create current camera position
    MapScreenState.cam = CameraPosition(
      target: LatLng(lat, lon),
      zoom: 14.4746,
    );
  }

  static Future fetchRecycleCenters() async {
    rcenterList = await RecycleCenterServiceFirebase.getCenterList();
    if (rcenterList == null) {
      print('unable to retrieve');
    } else {
      for (int i = 0; i < rcenterList.length; i++) {
        markers.add(new Marker(
          markerId: MarkerId(rcenterList[i]['name']),
          infoWindow: InfoWindow(title: rcenterList[i]['name']),
          icon: BitmapDescriptor.defaultMarker,
          position: LatLng(rcenterList[i]['lat'].toDouble(),
              rcenterList[i]['lon'].toDouble()),
        ));
        print(rcenterList[i]['lat'].toDouble());
      }
    }

    //return markers;
  }
}
