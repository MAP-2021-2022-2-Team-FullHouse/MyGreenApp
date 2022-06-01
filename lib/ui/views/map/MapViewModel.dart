import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'dart:math';
import 'package:my_green_app/model/RecycleCenter.dart';

class MapViewModel {
  CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('RecycleCenter');
  List centerList = [];
  List rcenterList = [];
  final Set<Marker> markers = Set();

  Future getCenterList() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();

    // Get data from docs and convert map to List
    centerList = querySnapshot.docs.map((doc) => doc.data()).toList();

    return centerList;
  }

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

  Future fetchRecycleCenters() async {
    rcenterList = await RecycleCenter.getCenterList();
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
      }
    }
    return markers;
  }

  Future fetchNearbyRecycleCenters() async {
    var lat, lon;
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    //var lastPosition=await Geolocator.getLastKnownPosition();
    lat = position.latitude;
    lon = position.longitude;
    dynamic r = await RecycleCenter.getCenterList();
    List nearbyCenterList = r;
    if (lat != null && lon != null) {
      for (int i = 0; i < nearbyCenterList.length; i++) {
        if (calculateDistance(lat, lon, nearbyCenterList[i]['lat'].toDouble(),
                nearbyCenterList[i]['lat'].toDouble()) >
            5) {
          nearbyCenterList.remove(i);
        }
      }
    }
    return nearbyCenterList;
  }
}
