
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'redeem_reward.dart';


class RedeemRewardBody extends StatelessWidget {
  final RedeemRewardScreenState _state;
  
   const RedeemRewardBody(this._state, {Key? key}) : super(key: key);
  
   
  

  @override
  Widget build(BuildContext context) {
  
    
    return ViewModelBuilder<RedeemRewardViewModel>.reactive(
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
                      height: 10.0,
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
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const SizedBox(
                        height: 5.0,
                      ),
                      const Text(
                        "Redeem Reward",
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
                      const SizedBox(
                        height: 5.0,
                      ),
                      ...buildRedeemTextFields(_state),
               
                      
                      // ignore: unnecessary_null_comparison
                      if (viewmodel.errorMessage != null)
                        Text(
                          viewmodel.errorMessage,
                          style: const TextStyle(color: Colors.red, fontSize: 20.0),
                        ),
                      const SizedBox(height: 10.0),
                      RedeemRewardButton(state: _state),
                     
                      const SizedBox(
                        height: 10.0,
                      ),
                     
                      
                    ],
                  ),
                )
              ])))),
      viewModelBuilder: () => RedeemRewardViewModel(),
    );
  }
  
}
