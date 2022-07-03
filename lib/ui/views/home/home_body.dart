import 'package:flutter/material.dart';
import 'package:my_green_app/model/recycling_info.dart';
import 'package:my_green_app/ui/views/home/home_build_recyclinginfolist.dart';
import 'package:my_green_app/ui/views/home/home_screenState.dart';
import 'package:my_green_app/ui/views/home/widget/logout_button.dart';
import 'package:stacked/stacked.dart';
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

    return Scaffold(
        //margin: const EdgeInsets.only(top: 5, bottom: 100),
        //width: MediaQuery.of(context).size.width,
        //height: MediaQuery.of(context).size.height,
        body: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          const SizedBox(height: 20),
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
                const SizedBox(height: 20),
              ],
            ),
          ),
          const SizedBox(height: 30),
          const Text(
            "Recycling Info",
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(color: Colors.grey, offset: Offset(2, 1), blurRadius: 10)
              ],
            ),
          ),
          const SizedBox(height: 10),
          Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //const SizedBox(height: 10),
                    StreamBuilder<List<RecyclingInfo>>(
                        stream: vm.getRecyclingInfoList(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return const Center(
                                child: Text('Something went wrong'));
                          }
                          if (snapshot.hasData) {
                            final recyclingInfos = snapshot.data!;
                            return ListView.builder(
                              physics: const ClampingScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              //children: ListView.builder(
                              itemCount: recyclingInfos.length,
                              itemBuilder: (context, index) =>
                                  BuildRecyclingInfoList(
                                      recyclingInfoList: recyclingInfos,
                                      index: index),
                            );
                            //context: context,
                            //color: const Color.fromARGB(255, 3, 140, 28),
                            //tiles: recyclingInfos
                            //    .map(buildRecyclingInfoList),
                            //).toList());
                            /*children: ListTile.divideTiles(
                                  context: context,
                                  color: const Color.fromARGB(255, 3, 140, 28),
                                  tiles: recyclingInfos
                                      .map(buildRecyclingInfoList),
                                ).toList());*/
                          } else {
                            return const Center(child: Text('No data found'));
                          }
                        }),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          ViewModelBuilder<HomeViewmodel>.reactive(
            builder: (context, viewmodel, child) =>
                LogoutButton(viewmodel: viewmodel, state: state),
            viewModelBuilder: () => HomeViewmodel(),
            onModelReady: (model) => model.listenToMessage(),
          ),
          const SizedBox(height: 20),
        ],
      ),
    ));
  }
}
