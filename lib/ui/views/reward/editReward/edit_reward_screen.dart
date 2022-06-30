import 'package:flutter/material.dart';
import 'package:my_green_app/ui/views/reward/adminViewReward/admin_reward_screen.dart';
import 'edit_reward.dart';

class EditRewardScreen extends StatefulWidget {
  final String docID;
  const EditRewardScreen({Key? key, required this.docID})
      : super(key: key);
  String get rID => docID;
  @override
  EditRewardScreenState createState() => EditRewardScreenState();
}

class EditRewardScreenState extends State<EditRewardScreen> {
  late String docID;
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final quantityController = TextEditingController();
  final pointController = TextEditingController();
   var fileField=TextEditingController();
  String? filename;
  
  EditRewardViewModel viewmodel = EditRewardViewModel();
  
  
  @override
  Widget build(BuildContext context) {
    docID = widget.docID;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 70,
        // Here we take the value from the MyHomePage object that was Editd by
        // the App.build method, and use it to set our appbar title.
        title: Text(
          'Edit Reward',
          style: TextStyle(color: Colors.black.withOpacity(1.0)),
        ),
      ),
      body: EditRewardBody(state:this),
    );
  }

  void editReward() async {
    dynamic result;
    try {
      result = await viewmodel.editReward(
        id: docID,
        title:titleController.text,
        description:descriptionController.text,
        quantity: int.parse(quantityController.text),
        point: int.parse(pointController.text),
        image:fileField.text,
        
      );
      
      if (result != null) {
        if(result=="ok")
          // ignore: use_build_context_synchronously
          {showConfirmDialog(context, "Edit Successfully!");}
        else if (result != "ok") {
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

  showConfirmDialog(BuildContext context, String text) {
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
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
