import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:my_green_app/ui/views/profile/profile_screen.dart';
import 'package:my_green_app/ui/views/profile/profile_viewmodel.dart';
import 'package:my_green_app/ui/views/profile/widget/button.dart';

class ProfileUploadPicture extends StatefulWidget {
  final ProfileScreenState state;
  const ProfileUploadPicture({required this.state});

  @override
  State<ProfileUploadPicture> createState() => ProfileUploadPictureState();
}

class ProfileUploadPictureState extends State<ProfileUploadPicture> {
  @override
  void initState() {
    super.initState();
    ProfileViewmodel.file = null;
    ProfileViewmodel.fileName = "";
  }

  ProfileViewmodel vm = ProfileViewmodel();
  //var fileField = TextEditingController();
  static late File file;
  var _text = '';
  TextInputType? key;
  get keyboard => key;

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 8),
          TextFormField(
            controller: widget.state.fileField,
            keyboardType: keyboard,
            decoration: InputDecoration(
                labelText: "Image File: ",
                // errorText: errorLon,
                labelStyle: TextStyle(color: Colors.black, fontSize: 12)),
            onChanged: (text) => setState(() => ""),
          ),
          ButtonWidget(
              text: 'Select File',
              icon: Icons.attach_file,
              onClicked: () {
                ProfileViewmodel.selectFile(widget.state);
                //widget.state.fileField.text=vm.fileName;
              }),
        ]);
  }
}
