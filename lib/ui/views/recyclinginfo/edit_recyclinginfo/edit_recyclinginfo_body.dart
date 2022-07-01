import 'package:flutter/material.dart';
import 'package:my_green_app/ui/views/recyclinginfo/edit_recyclinginfo/widget/edit_multilinetextfield.dart';
import 'package:stacked/stacked.dart';
import 'edit_recyclinginfo_screen.dart';
import 'widget/edit_textfield.dart';
import 'edit_recyclinginfo_button.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'edit_recyclinginfo_textfield.dart';
import 'edit_recyclinginfo_viewmodel.dart';

class EditRecyclingInfoBody extends StatelessWidget {
  final EditRecyclingInfoScreenState _state;
  UploadTask? task;
  File? file;
  EditRecyclingInfoBody(this._state);

  @override
  Widget build(BuildContext context) {
    EditRecyclingInfo_ViewModel vm = EditRecyclingInfo_ViewModel();

    return ViewModelBuilder<EditRecyclingInfo_ViewModel>.reactive(
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
                          child: const Text(
                        "Edit Recycling Info",
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
                      Text(
                        "Title",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                        textAlign: TextAlign.left,
                      ),
                      EditTextField(
                        controller: _state.titleController,
                        hintText: "Enter the Title",
                      ),
                      const SizedBox(height: 30.0),
                      Text(
                        "Content",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                        textAlign: TextAlign.left,
                      ),
                      EditMultiLineTextField(
                        controller: _state.contentController,
                        hintText: "Enter the Content",
                      ),
                      const SizedBox(height: 10.0),
                      EditRecyclingInfoImage(state: _state),
                      const SizedBox(height: 10.0),
                      new Positioned(
                        top: 50,
                        left: 0,
                        right: 0,
                        child: EditButton(state: _state),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                    ],
                  ),
                )
              ])))),
      viewModelBuilder: () => EditRecyclingInfo_ViewModel(),
    );
  }
}