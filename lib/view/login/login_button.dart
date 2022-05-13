import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mygreenapp/view/home/home_screen.dart';

class LoginButton extends StatelessWidget {
  final String email;
  final String password;
  final firestoreInstance = FirebaseFirestore.instance;
  LoginButton({
    this.email = "",
    this.password = "",
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        child: MaterialButton(
            onPressed: () async {
              try {
                final userCredential = await FirebaseAuth.instance
                    .signInWithEmailAndPassword(
                        email: email, password: password);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              } on FirebaseAuthException catch (e) {
                if (e.code == 'user-not-found') {
                  print("User not registered");
                } else if (e.code == 'wrong-password') {
                  print("Wrong password");
                }
              }
            },
            child: Text("Login")));
  }
}
