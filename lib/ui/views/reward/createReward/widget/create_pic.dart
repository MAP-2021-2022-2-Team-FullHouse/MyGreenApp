import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_green_app/ui/views/reward/createReward/widget/button.dart';

import '../create_reward_screen.dart';
import '../create_reward_viewmodel.dart';

class UploadPicture extends StatefulWidget {
  final CreateRewardScreenState state;
   const UploadPicture({Key? key, required this.state}) : super(key: key);

  @override
  State<UploadPicture> createState() => UploadPictureState();
}

class UploadPictureState extends State<UploadPicture> {
  @override
  void initState() {
    super.initState();
    CreateReward_ViewModel.file = null;
    CreateReward_ViewModel.fileName = "";
  }

  CreateReward_ViewModel viewmodel = CreateReward_ViewModel();
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
                CreateReward_ViewModel.selectFile(widget.state);
              }),
        ]);
  }
}
