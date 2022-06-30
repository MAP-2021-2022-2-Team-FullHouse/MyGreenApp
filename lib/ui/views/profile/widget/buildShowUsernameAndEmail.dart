import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';
import 'package:my_green_app/ui/views/profile/profile_screen.dart';
import 'package:my_green_app/ui/views/profile/profile_viewmodel.dart'
    as profileviewmodel;
import 'package:my_green_app/ui/views/profile/profile_viewmodel.dart';

late final String imagePath;
late final bool isEdit;
ProfileScreenState state = ProfileScreenState();
//late final VoidCallback onClicked;
Widget buildName(DocumentSnapshot<Map<String, dynamic>> user) => Padding(
  padding: const EdgeInsets.all(8.0),
  child:   Column(
    mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(width: 128, height: 128, child: futureBulder(user['image'])),
          const SizedBox(height: 8),
          Center(
            child: Text(
              
              user['name'],
              textAlign:TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, ),
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.fromLTRB(35, 3,10, 3),
            child: Align(
              alignment:Alignment.centerLeft,
              child: Text(
                "Email: " + user['email'],
                style: TextStyle(color: Colors.grey,fontSize: 18),
              ),
            ),
          ),
          
           Padding(
            padding: const EdgeInsets.fromLTRB(35, 3, 10, 3),
            child: Align(
              alignment:Alignment.centerLeft,
              child: Text(
                "Phone: " + user['phone'],
                style: TextStyle(color: Colors.grey,fontSize: 18),
              ),
            ),
          ),
          const SizedBox(height: 5),
           Padding(
           padding: const EdgeInsets.fromLTRB(12, 3, 12, 3),
            child: Align(
              alignment:Alignment.center,
              child: Text(
                  user['address'],
                 textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey,fontSize: 18),
              ),
            ),
          ),
         
          const SizedBox(height: 15),
        ],
      ),
);

Widget futureBulder(String imgUrl) {
  return FutureBuilder(
    future: state.getImgUrl(imgUrl),
    builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
      bool error = snapshot.data == null;
//I use NetworkImage for demonstration purpose, use it whatever widget u want
      return CircleAvatar(
        backgroundImage: error ? null : NetworkImage(snapshot.data!),
      );
    },
  );
}
