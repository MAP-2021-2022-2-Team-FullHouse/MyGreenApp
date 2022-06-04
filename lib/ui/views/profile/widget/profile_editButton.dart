import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_green_app/ui/views/profile/profile_edittextfields.dart';
import 'package:my_green_app/ui/views/profile/profile_screen.dart';
import 'package:my_green_app/ui/views/register/register_screen.dart';

class ProfileEditButton extends StatelessWidget {
  final firestoreInstance = FirebaseFirestore.instance;
  final ProfileScreenState state;

  ProfileEditButton(TextEditingController usernameController,
      TextEditingController phoneField, TextEditingController addrsField,
      {required this.state});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width / 2,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color.fromRGBO(195, 196, 141, 100),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 3,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: MaterialButton(
            onPressed: () => {
                  state.updateUser(
                      usernameController.text, phoneField.text, addrsField.text)
                },
            child: Text("Save")));
  }
}
