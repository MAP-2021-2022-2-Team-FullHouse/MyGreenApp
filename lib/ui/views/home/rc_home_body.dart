import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// ignore: library_prefixes
import 'package:my_green_app/model/user.dart' as AppUser;
import 'package:my_green_app/ui/views/home/home_screenState.dart';
import 'package:my_green_app/ui/views/home/widget/logout_button.dart';
import 'package:stacked/stacked.dart';
import '../home/home_viewmodel.dart';



class RCHomeBody extends StatelessWidget {
  final HomeScreenfulState state;
  const RCHomeBody({Key? key, required this.state}): super(key: key);
  
  @override
  Widget build(BuildContext context) {
HomeViewmodel vm=HomeViewmodel();



    return Center(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,

        children: <Widget>[
        const SizedBox(height:20),
        //   const Text("Recycle Center Home Page",
        //   style: TextStyle(
        //                   fontSize: 25,
        //                   color: Colors.black,
        //                   fontWeight: FontWeight.w700,
        //                   shadows: [
        //                     Shadow(
        //                         color: Colors.grey,
        //                         offset: Offset(2, 1),
        //                         blurRadius: 10)
        //                   ],
        //                 ),),
        //  const SizedBox(height:20),
       
        
      
          
                     

                   
                    
        SizedBox(height:5),
        const SizedBox(height:50),
          //       ViewModelBuilder<HomeViewmodel>.reactive(
          //   builder: (context, viewmodel, child)
          //      { return LogoutButton(viewmodel: viewmodel, state: state);},
          //   viewModelBuilder: () => HomeViewmodel(),
          // ),
                     
                      
                    ],
                  ),
                );
                
          
 
    
   
    
  }

  // Future<String> readUser() async {
  //   User? user = FirebaseAuth.instance.currentUser;
  //   final docUser =
  //       FirebaseFirestore.instance.collection("users").doc(user!.uid);
  //   final snapshot = await docUser.get();

  //   if (snapshot.exists) {
  //     return "Hi!${AppUser.User.fromJson(snapshot.data()!).name}";
  //   } else {
  //     return " ";
  //   }
  // }
  
}




