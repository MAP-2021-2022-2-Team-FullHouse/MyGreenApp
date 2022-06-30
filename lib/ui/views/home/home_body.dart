import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// ignore: library_prefixes
import 'package:my_green_app/model/user.dart' as AppUser;
import 'package:my_green_app/ui/views/home/home_screenState.dart';
import 'package:my_green_app/ui/views/home/widget/logout_button.dart';
import 'package:stacked/stacked.dart';
import '../../../model/PushNotification.dart';
import '../home/home_viewmodel.dart';

class HomeBody extends StatelessWidget {
  final HomeScreenfulState state;
  //final PushNotification? notification;
  final String notificationMsg;
  //final int totalNotifications;
  const HomeBody({Key? key, required this.state, required this.notificationMsg})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeViewmodel vm = HomeViewmodel();

    return Center(
      child: Column(
        children: <Widget>[
          /* notification != null
              //? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'TITLE: ${notification!.title}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'BODY: ${notification!.body}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                )
              : Container(), */
          const SizedBox(height: 20),
          /* Text(
            notificationMsg,
            textAlign: TextAlign.center,
          ), */
          const Text(
            "User Home Page",
            style: TextStyle(
              fontSize: 25,
              color: Colors.black,
              fontWeight: FontWeight.w700,
              shadows: [
                Shadow(color: Colors.grey, offset: Offset(2, 1), blurRadius: 10)
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              color: const Color.fromARGB(255, 2, 234, 255),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 80),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SizedBox(
                  height: 5.0,
                ),
                FutureBuilder<String>(
                    future: vm.getRewardPoint(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(child: Text(snapshot.error.toString()));
                      }
                      if (snapshot.hasData) {
                        return Wrap(children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: Column(children: [
                              const Text(
                                "Your Reward Point:",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  shadows: [
                                    Shadow(
                                        color: Colors.grey,
                                        offset: Offset(1, 1),
                                        blurRadius: 5)
                                  ],
                                ),
                              ),
                              Text(
                                '${snapshot.data}',
                                style: const TextStyle(
                                  fontSize: 38,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  shadows: [
                                    Shadow(
                                        color: Colors.grey,
                                        offset: Offset(1, 1),
                                        blurRadius: 5)
                                  ],
                                ),
                              ),
                            ]),
                          )
                        ]);
                      } else {
                        return const Center(child: Text('No data found'));
                      }
                    }),
                SizedBox(height: 5),
              ],
            ),
          ),
          const SizedBox(height: 50),
          ViewModelBuilder<HomeViewmodel>.reactive(
            builder: (context, viewmodel, child) =>
                LogoutButton(viewmodel: viewmodel, state: state),
            viewModelBuilder: () => HomeViewmodel(),
            onModelReady: (model) => model.listenToMessage(),
          ),
        ],
      ),
    );
  }
}
