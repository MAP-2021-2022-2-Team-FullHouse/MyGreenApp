import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_green_app/model/user.dart' as AppUser;
import 'package:my_green_app/ui/views/home/home_screenState.dart';
import 'package:my_green_app/ui/views/home/widget/logout_button.dart';
import 'package:stacked/stacked.dart';
import '../home/home_viewmodel.dart';

class HomeBody extends StatelessWidget {
  final HomeScreenfulState _state;
  const HomeBody(this._state);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("User Home Page"),
          FutureBuilder(
            future: readUser(),
            initialData: "Hi User",
            builder: (BuildContext context, AsyncSnapshot<String> text) {
              return SingleChildScrollView(
                child: Text(
                  text.data!,
                ),
              );
            },
          ),
          ViewModelBuilder<HomeViewmodel>.reactive(
            builder: (context, viewmodel, child) =>
                LogoutButton(viewmodel: viewmodel, state: _state),
            viewModelBuilder: () => HomeViewmodel(),
          ),
        ],
      ),
    );
  }

  Future<String> readUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    final docUser =
        FirebaseFirestore.instance.collection("users").doc(user!.uid);
    final snapshot = await docUser.get();

    if (snapshot.exists) {
      return "Hi!" + AppUser.User.fromJson(snapshot.data()!).name;
    } else {
      return " ";
    }
  }
}
