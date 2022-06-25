import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_green_app/ui/views/shop/manage_listing/create_listing/createlisting_screenstate.dart';
import 'package:my_green_app/ui/views/shop/manage_listing/create_listing/createlisting_viewmodel.dart';
import 'package:my_green_app/ui/views/shop/manage_listing/create_listing/widget/button.dart';

class UploadPicture extends StatefulWidget {
  final CreateListingScreenfulState state;
   const UploadPicture({Key? key, required this.state}) : super(key: key);

  @override
  State<UploadPicture> createState() => UploadPictureState();
}

class UploadPictureState extends State<UploadPicture> {
  @override
  void initState() {
    super.initState();
    CreateListingViewmodel.file = null;
    CreateListingViewmodel.fileName = "";
  }

  CreateListingViewmodel viewmodel = CreateListingViewmodel();
  static late File file;
  TextInputType? key;
  get keyboard => key;

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 8),
          TextFormField(
            controller: widget.state.fileField,
            keyboardType: keyboard,
            decoration: const InputDecoration(
                labelText: "Image File: ",
                labelStyle: TextStyle(color: Colors.black, fontSize: 12)),
            onChanged: (text) => setState(() => ""),
          ),
          ButtonWidget(
              text: 'Select File',
              icon: Icons.attach_file,
              onClicked: () {
                CreateListingViewmodel.selectFile(widget.state);
              }),
        ]);
  }
}
