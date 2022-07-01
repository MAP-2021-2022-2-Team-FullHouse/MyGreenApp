import 'package:flutter/material.dart';
import 'edit_recyclinginfo_screen.dart';
import 'widget/edit_textfield.dart';
import 'widget/edit_multilinetextfield.dart';
import 'package:my_green_app/model/recycling_info.dart';
import 'edit_recyclinginfo_viewmodel.dart';

List<Widget> buildEditTextFields(
        EditRecyclingInfoScreenState state, RecyclingInfo recyclingInfo) =>
    [
      const Text(
        "Title",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        textAlign: TextAlign.left,
      ),
      EditTextField(
        controller: state.titleController..text = recyclingInfo.title,
      ),
      const Text(
        "Content",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        textAlign: TextAlign.left,
      ),
      EditMultiLineTextField(
        controller: state.contentController..text = recyclingInfo.content,
      ),
      const Text(
        "Image File",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        textAlign: TextAlign.left,
      ),
      EditTextField(
        controller: state.fileField..text = recyclingInfo.image,
      ),
      ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: const Color.fromRGBO(29, 194, 95, 1),
            minimumSize: const Size.fromHeight(50),
          ),
          onPressed: () async {
            EditRecyclingInfo_ViewModel.selectFile(state);
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.attach_file, size: 28),
              SizedBox(width: 16),
              Text(
                "Select Image",
                style: TextStyle(fontSize: 22, color: Colors.white),
              ),
            ],
          )),
    ];
