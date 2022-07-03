import 'package:flutter/material.dart';
import 'package:my_green_app/model/recycling_info.dart';
import 'package:my_green_app/ui/views/admin/admin_build_recyclinginfolist.dart';
import 'package:my_green_app/ui/views/admin/admin_screenstate.dart';
import 'package:my_green_app/ui/views/admin/widget/logoutbutton.dart';
import 'package:stacked/stacked.dart';
import '../admin/admin_viewmodel.dart';

class AdminBody extends StatelessWidget {
  final AdminScreenfulState _state;
  const AdminBody(this._state);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AdminViewmodel>.reactive(
      builder: (context, vm, child) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 30),
              const Text(
                "Recycling Info",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                        color: Colors.grey,
                        offset: Offset(2, 1),
                        blurRadius: 10)
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
                                return const Center(
                                    child: Text('No data found'));
                              }
                            }),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => AdminViewmodel(),
    );
  }
}
