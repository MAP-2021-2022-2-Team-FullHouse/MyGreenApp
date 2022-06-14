
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:stacked/stacked.dart';
import 'CreateReward_Screen.dart';
import 'CreateReward_Textfield.dart';
import 'CreateRewardButton.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:geocoding/geocoding.dart';

import 'CreateReward_ViewModel.dart';


class CreateRewardBody extends StatelessWidget {
  final CreateRewardScreenState _state;
  
   CreateRewardBody(this._state);
  
   
  

  @override
  Widget build(BuildContext context) {
  CreateReward_ViewModel vm=CreateReward_ViewModel();
    
    return ViewModelBuilder<CreateReward_ViewModel>.reactive(
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
                  child:SizedBox(
                        height: 10.0,
                      )
                      // Image.asset('assets/logo.png', height: 150, width: 250),
                ),
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
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        "Create Reward",
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          shadows: [
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
               
                      
                      if (viewmodel.errorMessage != null)
                        Text(
                          viewmodel.errorMessage,
                          style: TextStyle(color: Colors.red, fontSize: 20.0),
                        ),
                      const SizedBox(height: 10.0),
                      CreateRewardButton(state: _state),
                     
                      SizedBox(
                        height: 10.0,
                      ),
                     
                      
                    ],
                  ),
                )
              ])))),
      viewModelBuilder: () => CreateReward_ViewModel(),
    );
  }
  
}
