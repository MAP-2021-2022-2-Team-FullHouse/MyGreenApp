import 'package:flutter/material.dart';
import 'package:my_green_app/ui/views/reward/adminViewReward/admin_reward_screen.dart';
import 'create_reward_viewmodel.dart';
import 'create_reward_body.dart';

class CreateRewardScreen extends StatefulWidget {
  const CreateRewardScreen({Key? key}) : super(key: key);

  static Route route() => MaterialPageRoute(builder: (_) => const CreateRewardScreen());

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
          point:int.parse(pointController.text),
          
          );
          
      if (result != null) {
        if (result == 'ok') {
         
           // ignore: use_build_context_synchronously
           showConfirmDialog(context, "Created Successfully!");
        } else if (result != "ok") {
          // ignore: use_build_context_synchronously
          showAlertDialog(context, result);
        } 
      }else{
        // ignore: use_build_context_synchronously
        showAlertDialog(context, "Something went wrong. Please try again.");
      }
     
    } catch (e) {
      showAlertDialog(context, "Something went wrong. Please try again.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 70,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(
          'Reward',
          style: TextStyle(color: Colors.black.withOpacity(1.0)),
        ),
        
      ),
      body:CreateRewardBody(state:this),
    );
  }
  showConfirmDialog(BuildContext context, String text){
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        //Navigator.pushNamed(context, Routes.homeRoute);
        Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const AdminRewardScreen(),
            ));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Message"),
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
      child: const Text("OK"),
      onPressed: () {
        //Navigator.pushNamed(context, routes.createRecycleCenterRoute);
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Error"),
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
