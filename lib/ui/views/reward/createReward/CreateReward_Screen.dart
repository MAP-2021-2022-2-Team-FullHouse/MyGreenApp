import 'package:flutter/material.dart';
import 'package:my_green_app/app/routes.dart';
import 'package:my_green_app/ui/views/login/widget/login_textfield.dart';
import 'package:geolocator/geolocator.dart';
import 'package:my_green_app/ui/views/recyclecenter/recyclecenter_screen.dart';
import 'package:my_green_app/constants/routes_path.dart' as routes;
import 'package:my_green_app/app/router.dart' as router;

import '../../admin/admin_screen.dart';
import '../../home/home_screen.dart';
import 'CreateReward_ViewModel.dart';
import 'CreateReward_body.dart';
class CreateRewardScreen extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (_) => CreateRewardScreen());

  @override
  CreateRewardScreenState createState() => CreateRewardScreenState();
}

class CreateRewardScreenState extends State<CreateRewardScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final quantityController = TextEditingController();
  final pointController = TextEditingController();

  CreateReward_ViewModel viewmodel = CreateReward_ViewModel();
  

   void addReward() async {
    dynamic result;
    try {
      result = await viewmodel.addReward(
          title: titleController.text,
          description: descriptionController.text,
          quantity: int.parse(quantityController.text),
          point:double.parse(pointController.text),
          
          );
          print(result);
      if (result != null) {
        if (result == 'Email is registered.') {
         
          showAlertDialog(context, "Email is registered.");
        } else if (result == "weak-password") {
          showAlertDialog(context, "Weak password");
        } else if (result == 'invalid-email') {
          showAlertDialog(context, "Invalid email address.");
        }else if(result=="Name duplicated"){
          showAlertDialog(context, "This recycle center name is already registered.");
        }else if(result=="Image duplicated"){
          showAlertDialog(context, "This image is already uploaded.");
        }
        else if(result=="Phone duplicated"){
          showAlertDialog(context, "This phone is already registered.");
        }
        else {
          showConfirmDialog(context, "Created Successfully!");
          
        }
      }
     
    } catch (e) {
      showAlertDialog(context, "Form is not completely filled.");
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(
          'Reward',
          style: TextStyle(color: Colors.black.withOpacity(1.0)),
        ),
        
      ),
      body:CreateRewardBody(this),
    );
  }
  showConfirmDialog(BuildContext context, String text){
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        //Navigator.pushNamed(context, Routes.homeRoute);
        Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => CreateRewardScreen(),
            ));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Message"),
      content: Text(text),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  showAlertDialog(BuildContext context, String text) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        //Navigator.pushNamed(context, routes.createRecycleCenterRoute);
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Error"),
      content: Text(text),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
