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

// ignore: must_be_immutable
class CreateRecyclingInfoBody extends StatelessWidget {
  final CreateRecyclingInfoScreenState _state;
  UploadTask? task;
  File? file;
  // ignore: use_key_in_widget_constructors
  CreateRecyclingInfoBody(this._state);

  @override
  Widget build(BuildContext context) {
    CreateRecyclingInfo_ViewModel vm = CreateRecyclingInfo_ViewModel();

    return ViewModelBuilder<CreateRecyclingInfo_ViewModel>.reactive(
      builder: (context, viewmodel, _) => Scaffold(
          body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
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
                const SizedBox(
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
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const SizedBox(
                        height: 15.0,
                      ),
                      const Center(
                          child: Text(
                        "Create Recycling Info",
                        textAlign: TextAlign.center,
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
                      )),
                      const SizedBox(
                        height: 15.0,
                      ),
                      const Text(
                        "Title",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                        textAlign: TextAlign.left,
                      ),
                      CreateTextField(
                        controller: _state.titleController,
                        hintText: "Enter the Title",
                      ),
                      const SizedBox(height: 30.0),
                      const Text(
                        "Content",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                        textAlign: TextAlign.left,
                      ),
                      CreateMultiLineTextField(
                        controller: _state.contentController,
                        hintText: "Enter the Content",
                      ),
                      const SizedBox(height: 10.0),
                      CreateRecyclingInfoImage(state: _state),
                      const SizedBox(height: 10.0),
                      Positioned(
                        top: 50,
                        left: 0,
                        right: 0,
                        child: CreateButton(state: _state),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                    ],
                  ),
                )
              ])))),
      viewModelBuilder: () => CreateRecyclingInfo_ViewModel(),
    );
  }
}
