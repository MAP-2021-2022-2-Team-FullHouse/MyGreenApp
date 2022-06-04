import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_green_app/ui/views/profile/profile_edittextfields.dart';
import 'package:my_green_app/ui/views/profile/profile_screen.dart';
import 'package:my_green_app/ui/views/profile/profile_uploadPic.dart';
import 'package:my_green_app/ui/views/profile/profile_viewmodel.dart';
import 'package:my_green_app/ui/views/profile/widget/profile_builder.dart';
import 'package:my_green_app/ui/views/profile/widget/profile_editButton.dart';
import 'package:my_green_app/ui/views/profile/widget/profile_textField.dart';
import 'package:stacked/stacked.dart';

class EditProfile extends StatelessWidget {
  final usernameController = TextEditingController();
  final phoneField = TextEditingController();
  final addrsField = TextEditingController();
  EditProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewmodel>.reactive(
      builder: (context, model, child) => Material(
          child: Scaffold(
              body: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: SingleChildScrollView(
                      child: Container(
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
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 50),
                          child: Center(
                              child: Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16.0),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 15),
                                  child: ListView(
                                    children: [
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      const Text(
                                        "Edit Profile",
                                        style: TextStyle(
                                          fontSize: 25,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                          shadows: [
                                            Shadow(
                                                color: Colors.grey,
                                                offset: Offset(2, 1),
                                                blurRadius: 10)
                                          ],
                                        ),
                                      ),
                                      StreamBuilder<
                                          DocumentSnapshot<
                                              Map<String, dynamic>>>(
                                        stream: model.getUserData(),
                                        builder: (ctx, streamSnapshot) {
                                          if (streamSnapshot.hasError) {
                                            return Center(
                                                child: Text(
                                                    'Something went wrong'));
                                          }
                                          if (streamSnapshot.hasData) {
                                            return Column(
                                              children: [
                                                ProfileWidget(
                                                    imagePath: streamSnapshot
                                                        .data!['image']),
                                                SizedBox(height: 5),
                                                ProfileUploadPicture(
                                                    state:
                                                        ProfileScreenState()),
                                                SizedBox(height: 5),
                                                //futureBulder(streamSnapshot.data!['image']),
                                                ...buildProfileTextFields(
                                                    ProfileScreenState(),
                                                    streamSnapshot.data!),
                                                SizedBox(height: 5),
                                              ],
                                            );
                                          } else {
                                            return Center(
                                                child: Text('No data found.'));
                                          }
                                        },
                                      ),
                                      ProfileEditButton(usernameController,
                                          phoneField, addrsField,
                                          state: ProfileScreenState()),
                                    ],
                                  )))))))),
      viewModelBuilder: () => ProfileViewmodel(),
    );
  }
}
