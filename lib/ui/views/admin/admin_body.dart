import 'package:flutter/material.dart';
import 'package:my_green_app/model/recycling_info.dart';
import 'package:my_green_app/ui/views/admin/admin_build_recyclinginfolist.dart';
import 'package:my_green_app/ui/views/admin/admin_screenstate.dart';
import 'package:my_green_app/ui/views/admin/widget/logoutbutton.dart';
import 'package:stacked/stacked.dart';
import '../admin/admin_viewmodel.dart';

class AdminBody extends StatelessWidget {
  final AdminScreenfulState state;
  const AdminBody(this.state, {super.key});

  @override
  Widget build(BuildContext context) {
    //return ViewModelBuilder<AdminViewmodel>.reactive(
    // builder: (context, model, child) =>
    AdminViewmodel vm = AdminViewmodel();
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            "Admin Home Page",
            style: TextStyle(
              fontSize: 25,
              color: Colors.black,
              fontWeight: FontWeight.w700,
              shadows: [
                Shadow(color: Colors.grey, offset: Offset(2, 1), blurRadius: 10)
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
          ViewModelBuilder<AdminViewmodel>.reactive(
            builder: (context, viewmodel, child) =>
                LogoutButton(viewmodel: viewmodel, state: state),
            viewModelBuilder: () => AdminViewmodel(),
          ),
          const SizedBox(height: 20),
        ],
      ),
    ));
  }
}
