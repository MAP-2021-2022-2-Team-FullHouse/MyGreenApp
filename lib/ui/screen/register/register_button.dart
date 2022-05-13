import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterButton extends StatelessWidget {
  final String email;
  final String password;
  final String name, address, phone;
  final firestoreInstance = FirebaseFirestore.instance;
  RegisterButton(
      {this.email = "",
      this.password = "",
      this.address = "",
      this.name = "",
      this.phone = ""});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: MaterialButton(
            onPressed: () async {
              try {
                final userCredential =
                    await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: email,
                  password: password,
                );
              } on FirebaseAuthException catch (e) {
                if (e.code == 'weak-password') {
                  print('Weak password');
                } else if (e.code == 'email-already-in-use') {
                  print('Email registered');
                } else if (e.code == 'invalid-email') {
                  print('Invalid email');
                }
              }
              firestoreInstance.collection("User").add({
                "name": name,
                "phone": phone,
                "email": email,
                "address": address
              }).then((value) {
                print(value.id);
              });
            },
            child: Text("Go Green!")));
  }
}
