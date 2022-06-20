import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../../../model/RewardUnit.dart';
import 'edit_tracking_no.dart';


class EditTrackingNoBody extends StatelessWidget {
  final EditTrackingNoScreenState _state;

  const EditTrackingNoBody(this._state, {Key? key}) : super(key: key);
  

 

  @override
  Widget build(BuildContext context) {
    //EditRecycleCenter_ViewModel vm=EditRecycleCenter_ViewModel();
    //final rc = ModalRoute.of(context)!.settings.arguments;
    return ViewModelBuilder<EditTrackingNoViewModel>.reactive(
      builder: (context, viewmodel, _) => Scaffold(
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
              child: SingleChildScrollView(
                  child: Column(children: [
                const SizedBox(
                  height: 11.0,
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
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
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const SizedBox(
                        height: 5.0,
                      ),
                      FutureBuilder<RewardUnit?>(
                          future: viewmodel.readRewardUnit(_state.docID),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return const Center(
                                  child: Text('Something went wrong'));
                            }
                            if (snapshot.hasData) {
                              final rc = snapshot.data!;
                              return Wrap(
                                  children: buildEditTrackingNoTextFields(_state, rc));
                            } else {
                              return const Center(child: Text('No data found'));
                            }
                          }),
                      // ignore: unnecessary_null_comparison
                      if (viewmodel.errorMessage != null)
                        Text(
                          viewmodel.errorMessage,
                          style: const TextStyle(color: Colors.red, fontSize: 20.0),
                        ),
                      const SizedBox(height: 3.0),
                      EditTrackingNoButton(state: _state),
                      const SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                )
              ])))),
      viewModelBuilder: () => EditTrackingNoViewModel(),
    );
  }
}
