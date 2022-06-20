import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_green_app/ui/views/profile/profile_buttons.dart';
import 'package:my_green_app/ui/views/profile/profile_screen.dart';
import 'package:my_green_app/ui/views/profile/profile_viewmodel.dart';
import 'package:my_green_app/ui/views/profile/widget/buildShowUsernameAndEmail.dart';
import 'package:stacked/stacked.dart';

class ProfileBody extends StatelessWidget {
  final ProfileScreenState _state;
  const ProfileBody(this._state);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewmodel>.reactive(
      builder: (context, model, child) => Scaffold(
          body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromRGBO(209, 239, 181, 100),
                      Color.fromRGBO(211, 250, 214, 100)
                    ]),
              ),
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
              child: Center(
                  child: Container(
                margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                decoration: BoxDecoration(
                  borderRadius: new BorderRadius.circular(16.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: ListView(
                  children: [
                    StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                      stream: model.getUserData(),
                      builder: (ctx, streamSnapshot) {
                        if (streamSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: Colors.blue,
                            ),
                          );
                        }
                        if (streamSnapshot.hasError) {
                          return const Center(
                              child: Text('Something went wrong'));
                        }
                        if (streamSnapshot.hasData) {
                          return Column(
                            children: [
                              //SizedBox(height: 5),
                              //futureBulder(streamSnapshot.data!['image']),
                              const SizedBox(height: 5),
                              buildName(streamSnapshot.data!),
                              const SizedBox(height: 5),
                              ProfileButton(
                                  viewmodel: ProfileViewmodel(), state: _state),
                              const SizedBox(height: 5),
                            ],
                          );
                        } else {
                          return const Center(child: Text('No data found.'));
                        }
                      },
                    ),
                  ],
                ),
              )))),
      viewModelBuilder: () => ProfileViewmodel(),
    );
  }
}
