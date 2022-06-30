import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:my_green_app/ui/views/home/home_viewmodel.dart';

class HomeRedeemPoint extends StatefulWidget {
  const HomeRedeemPoint({Key? key}) : super(key: key);

  @override
  State<HomeRedeemPoint> createState() => _HomeRedeemPointState();
}

class _HomeRedeemPointState extends State<HomeRedeemPoint> {
  String role='';
  @override
  void initState(){
    setRole();
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    HomeViewmodel vm=HomeViewmodel();
      if( HomeViewmodel.role.compareTo("user")==0)
      {

      }
    return Container(
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
                      SizedBox(
                        height: 5.0,
                      ),
                      FutureBuilder<String>(
                      future: vm.getRewardPoint(),
                     
                      builder: (context, snapshot) {
                        if(snapshot.hasError){
                          return Center(child: Text(snapshot.error.toString()));
                        }
                        if(snapshot.hasData)
                        {
                          return Wrap(children: <Widget>[
                            Padding(
                padding: const EdgeInsets.only(top: 16),
                child: 
                Column(
                  children: [
                    const Text("Your Reward Point:",
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
                    Text('${snapshot.data}',
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
                          ),),




                                  ],))]);
                        }else{
                          return const Center(child: Text('No data found'));
                        }
                      
                      },
                    ),

                      ] )  );

    
  }
  Future setRole() async{
    role=await HomeViewmodel().myRole();
  }
}

