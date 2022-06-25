import 'package:flutter/material.dart';
import '../adminRewardRedemption/reward_redemption_screen.dart';
import 'edit_tracking_no.dart';

class EditTrackingNoScreen extends StatefulWidget {
  final String docID;
  const EditTrackingNoScreen({Key? key, required this.docID})
      : super(key: key);
  String get rID => docID;
  @override
  EditTrackingNoScreenState createState() => EditTrackingNoScreenState();
}

class EditTrackingNoScreenState extends State<EditTrackingNoScreen> {
  late String docID;
  final trackingnoController = TextEditingController();
  
  
  EditTrackingNoViewModel viewmodel = EditTrackingNoViewModel();
  
  
  @override
  Widget build(BuildContext context) {
    docID = widget.docID;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        // Here we take the value from the MyHomePage object that was Editd by
        // the App.build method, and use it to set our appbar title.
        title: Text(
          'Edit Tracking Number',
          style: TextStyle(color: Colors.black.withOpacity(1.0)),
        ),
      ),
      body: EditTrackingNoBody(this),
    );
  }

  void editTrackingNo() async {
    dynamic result;
    try {
      result = await viewmodel.editRewardUnit(
        id: docID,
        trackingNo:trackingnoController.text,
        
      );
      
      if (result != null) {
        if(result=="ok")
          // ignore: use_build_context_synchronously
          {showConfirmDialog(context, "Tracking Number Is Added Successfully!");}
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
          builder: (context) => const RewardRedemptionScreen(),
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
