import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:my_green_app/ui/views/recyclecenter/EditRecycleCenter/EditRecycleCenter_Textfield.dart';
import 'package:stacked/stacked.dart';
import 'EditRecycleCenter_Screen.dart';
import 'EditRecycleCenterButton.dart';
import 'dart:io';
import 'package:my_green_app/model/RecycleCenter.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'EditRecycleCenter_ViewModel.dart';

class EditRecycleCenterBody extends StatelessWidget {
  final EditRecycleCenterScreenState _state;
  UploadTask? task;
  File? file;
  EditRecycleCenterBody(this._state);
  String location = 'current location not found';

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> setLocation(Position position) async {
    location = 'Lat: ${position.latitude} , Long: ${position.longitude}';
  }

  @override
  Widget build(BuildContext context) {
    //EditRecycleCenter_ViewModel vm=EditRecycleCenter_ViewModel();
    //final rc = ModalRoute.of(context)!.settings.arguments;
    return ViewModelBuilder<EditRecycleCenter_ViewModel>.reactive(
      builder: (context, viewmodel, _) => Scaffold(
          body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromRGBO(209, 239, 181, 100),
                      Color.fromRGBO(211, 250, 214, 100)
                    ]),
              ),
              child: SingleChildScrollView(
                  child: Column(children: [
                Container(
                    child: SizedBox(
                  height: 11.0,
                )),
                Container(
                  margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  decoration: new BoxDecoration(
                    borderRadius: new BorderRadius.circular(16.0),
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
                  padding: EdgeInsets.symmetric(horizontal: 35),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 5.0,
                      ),
                      FutureBuilder<RecycleCenter?>(
                          future: viewmodel.readCenter(_state.rcEmail),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Center(
                                  child: Text('Something went wrong'));
                            }
                            if (snapshot.hasData) {
                              final rc = snapshot.data!;
                              return Wrap(
                                  children: buildEditTextFields(_state, rc));
                            } else {
                              return Center(child: Text('No data found'));
                            }
                          }),
                      if (viewmodel.errorMessage != null)
                        Text(
                          viewmodel.errorMessage,
                          style: TextStyle(color: Colors.red, fontSize: 20.0),
                        ),
                      const SizedBox(height: 3.0),
                      EditButton(state: _state),
                      SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                )
              ])))),
      viewModelBuilder: () => EditRecycleCenter_ViewModel(),
    );
  }
}
