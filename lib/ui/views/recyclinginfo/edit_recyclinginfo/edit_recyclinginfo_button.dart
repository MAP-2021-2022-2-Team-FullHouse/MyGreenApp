import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'edit_recyclinginfo_screen.dart';

class EditButton extends StatelessWidget {
  final firestoreInstance = FirebaseFirestore.instance;
  final EditRecyclingInfoScreenState state;

  EditButton({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width / 2,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color.fromRGBO(195, 196, 141, 100),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 3,
              offset: const Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: MaterialButton(
            onPressed: () => {state.editRecyclingInfo()}, child: const Text("Save")));
  }
}
