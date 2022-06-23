import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_green_app/ui/views/shop/manage_listing/edit_listing/editlisting_screenstate.dart';
import 'package:my_green_app/ui/views/shop/manage_listing/edit_listing/editlisting_viewmodel.dart';
import 'package:my_green_app/ui/views/shop/manage_listing/edit_listing/widget/button.dart';


class EditPicture extends StatefulWidget {
  final EditListingScreenfulState state;
  const EditPicture({Key? key, required this.state}) : super(key: key);

  @override
  State<EditPicture> createState() => EditPictureState();
}

class EditPictureState extends State<EditPicture> {
  @override
  void initState() {
    super.initState();
    EditListingViewmodel.file = null;
    EditListingViewmodel.fileName = "";
  }

  EditListingViewmodel viewmodel = EditListingViewmodel();
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
                EditListingViewmodel.selectFile(widget.state);
              }),
        ]);
  }
}
