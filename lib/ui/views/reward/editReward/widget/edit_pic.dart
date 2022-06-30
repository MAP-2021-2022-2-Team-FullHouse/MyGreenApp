import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_green_app/ui/views/shop/manage_listing/edit_listing/editlisting_screenstate.dart';
import 'package:my_green_app/ui/views/shop/manage_listing/edit_listing/editlisting_viewmodel.dart';
import 'package:my_green_app/ui/views/shop/manage_listing/edit_listing/widget/button.dart';

import '../../../../../model/Reward.dart';
import '../edit_reward_screen.dart';
import '../edit_reward_viewmodel.dart';


class EditPicture extends StatefulWidget {
  final EditRewardScreenState state;
  final Reward reward;
  const EditPicture({Key? key, required this.state, required this.reward}) : super(key: key);

  @override
  State<EditPicture> createState() => EditPictureState();
}

class EditPictureState extends State<EditPicture> {
  @override
  void initState() {
    super.initState();
    //EditRewardViewModel.file = null;
    EditRewardViewModel.fileName = "";
  }

  EditRewardViewModel viewmodel = EditRewardViewModel();
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
            controller: widget.state.fileField..text="${widget.reward.image}",
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
                EditRewardViewModel.selectFile(widget.state);
              }),
        ]);
  }
}
