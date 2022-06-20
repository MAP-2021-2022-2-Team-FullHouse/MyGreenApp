import 'package:flutter/material.dart';
import 'package:my_green_app/ui/views/recyclinginfo/create_recyclinginfo/widget/create_multilinetextfield.dart';
import 'package:stacked/stacked.dart';
import 'create_recyclinginfo_screen.dart';
import 'widget/create_textfield.dart';
import 'create_recyclinginfo_button.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'create_recyclinginfo_image.dart';
import 'create_recyclinginfo_viewmodel.dart';

class CreateRecyclingInfoBody extends StatelessWidget {
  final CreateRecyclingInfoScreenState _state;
  UploadTask? task;
  File? file;
  CreateRecyclingInfoBody(this._state);

  @override
  Widget build(BuildContext context) {
    CreateRecyclingInfo_ViewModel vm = CreateRecyclingInfo_ViewModel();

    return ViewModelBuilder<CreateRecyclingInfo_ViewModel>.reactive(
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
                        "Create Recycling Info",
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
                      CreateTextField(
                        controller: _state.titleController,
                        hintText: "Recycle Information Title",
                        labelText: "Title: ",
                      ),
                      const SizedBox(height: 10.0),
                      CreateRecyclingInfoImage(state: _state),
                      const SizedBox(height: 10.0),
                      CreateMultiLineTextField(
                        controller: _state.contentController,
                        hintText: "Enter the content",
                        labelText: "Content: ",
                      ),
                      CreateButton(state: _state),
                      SizedBox(
                        height: 10.0,
                      ),
                    ],
                  ),
                )
              ])))),
      viewModelBuilder: () => CreateRecyclingInfo_ViewModel(),
    );
  }
}
