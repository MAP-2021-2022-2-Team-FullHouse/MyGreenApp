import 'package:flutter/material.dart';
import 'package:my_green_app/ui/views/reward/editReward/widget/edit_pic.dart';
import 'package:stacked/stacked.dart';
import '../../../../model/Reward.dart';
import 'edit_reward.dart';


class EditRewardBody extends StatelessWidget {
  final EditRewardScreenState state;

  const EditRewardBody({Key?key, required this.state}):super(key: key);

  @override
  Widget build(BuildContext context) {
    //EditRecycleCenter_ViewModel vm=EditRecycleCenter_ViewModel();
    //final rc = ModalRoute.of(context)!.settings.arguments;
    return ViewModelBuilder<EditRewardViewModel>.reactive(
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
                      FutureBuilder<Reward?>(
                          future: viewmodel.readReward(state.docID),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return const Center(
                                  child: Text('Something went wrong'));
                            }
                            if (snapshot.hasData) {
                              final rc = snapshot.data!;
                              return Wrap(
                                  children: buildEditRewardTextFields(state, rc));
                            } else {
                              return const Center(child: Text('No data found'));
                            }
                          }),
                      // ignore: unnecessary_null_comparison
                      // if (viewmodel.errorMessage != null)
                      //   Text(
                      //     viewmodel.errorMessage,
                      //     style: const TextStyle(color: Colors.red, fontSize: 20.0),
                      //   ),
                      
                      const SizedBox(height: 3.0),
                      EditRewardButton(state: state),
                      const SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                )
              ])))),
      viewModelBuilder: () => EditRewardViewModel(),
    );
  }
}
