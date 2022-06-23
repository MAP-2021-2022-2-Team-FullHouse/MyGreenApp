
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'create_recycle_center.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';


// ignore: must_be_immutable
class CreateRecycleCenterBody extends StatelessWidget {
  final CreateRecycleCenterScreenState _state;
  UploadTask? task;
  File? file;
   // ignore: use_key_in_widget_constructors
   CreateRecycleCenterBody(this._state);
   String location='current location not found';

//  Future<Position> _getGeoLocationPosition() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     // Test if location services are enabled.
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       // Location services are not enabled don't continue
//       // accessing the position and request users of the
//       // App to enable the location services.
//       await Geolocator.openLocationSettings();
//       return Future.error('Location services are disabled.');
//     }

//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         // Permissions are denied, next time you could try
//         // requesting permissions again (this is also where
//         // Android's shouldShowRequestPermissionRationale
//         // returned true. According to Android guidelines
//         // your App should show an explanatory UI now.
//         return Future.error('Location permissions are denied');
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       // Permissions are denied forever, handle appropriately.
//       return Future.error(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }

//     // When we reach here, permissions are granted and we can
//     // continue accessing the position of the device.
//     return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//   }
//  Future<void> setLocation(Position position)async {
//     location ='Lat: ${position.latitude} , Long: ${position.longitude}';
    
//   }
   
  

  @override
  Widget build(BuildContext context) {
  // CreateRecycleCenter_ViewModel vm=CreateRecycleCenter_ViewModel();
    
    return ViewModelBuilder<CreateRecycleCenter_ViewModel>.reactive(
      builder: (context, viewmodel, _) => Scaffold(
          body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    // ignore: prefer_const_literals_to_create_immutables
                    colors: [
                       Color.fromRGBO(209, 239, 181, 100),
                       Color.fromRGBO(211, 250, 214, 100)
                    ]),
              ),
              child: SingleChildScrollView(
                  child: Column(children: [
                SizedBox(
                      height: 10.0,
                    ),
                Container(
                  margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        "Create Recycle Center",
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          shadows: const [
                            Shadow(
                                color: Colors.grey,
                                offset: Offset(2, 1),
                                blurRadius: 10)
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      ...buildCreateTextFields(_state),
                      CreateLatLon(state:_state),
                      
                      // ignore: unnecessary_null_comparison
                      if (viewmodel.errorMessage != null)
                        Text(
                          viewmodel.errorMessage,
                          style: TextStyle(color: Colors.red, fontSize: 20.0),
                        ),
                      const SizedBox(height: 10.0),
                      CreateButton(state: _state),
                     
                      SizedBox(
                        height: 10.0,
                      ),
                     
                      
                    ],
                  ),
                )
              ])))),
      viewModelBuilder: () => CreateRecycleCenter_ViewModel(),
    );
  }
  
}
