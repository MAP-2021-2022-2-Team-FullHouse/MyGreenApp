import 'package:flutter/material.dart';
import 'package:my_green_app/ui/views/recyclinginfo/view/viewrecyclinginfo_screen.dart';
import 'package:my_green_app/ui/views/recyclinginfo/view/viewrecyclinginfo_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:my_green_app/model/recycling_info.dart';

import 'viewrecyclinginfo_build.dart';

class ViewRecyclingInfoBody extends StatelessWidget {
  final ViewRecyclingInfoScreenState _state;
  ViewRecyclingInfoBody(this._state);

  @override
  Widget build(BuildContext context) {
    //EditRecycleCenter_ViewModel vm=EditRecycleCenter_ViewModel();
    //final rc = ModalRoute.of(context)!.settings.arguments;
    return ViewModelBuilder<ViewRecyclingInfo_ViewModel>.reactive(
      builder: (context, viewmodel, _) => Scaffold(
          body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromRGBO(209, 239, 181, 100),
                      Color.fromRGBO(211, 250, 214, 100)
                    ]),
              ),
              child: SingleChildScrollView(
                  child: Column(children: [
                Container(
                    child: SizedBox(
                  height: 11.0,
                )),
                Container(
                  margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  decoration: new BoxDecoration(
                    borderRadius: new BorderRadius.circular(16.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 35),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 5.0,
                      ),
                      FutureBuilder<RecyclingInfo?>(
                          future: viewmodel.readRecyclingInfo(_state.rlId),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Center(
                                  child: Text('Something went wrong'));
                            }
                            if (snapshot.hasData) {
                              final rc = snapshot.data!;
                              return Wrap(
                                  children: buildRecyclingInfo(_state, rc));
                            } else {
                              return Center(child: Text('No data found'));
                            }
                          }),
                      SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                )
              ])))),
      viewModelBuilder: () => ViewRecyclingInfo_ViewModel(),
    );
  }
}
