import 'package:flutter/material.dart';
import 'package:my_green_app/constants/routes_path.dart' as routes;
import 'create_recyclinginfo_screen.dart';
import 'create_recyclinginfo_viewmodel.dart';
import 'widget/create_button.dart';

class CreateRecyclingInfoImage extends StatefulWidget {
  final CreateRecyclingInfoScreenState state;

  // ignore: use_key_in_widget_constructors
  const CreateRecyclingInfoImage({required this.state});

  @override
  State<CreateRecyclingInfoImage> createState() =>
      _CreateRecyclingInfoImageState();
}

class _CreateRecyclingInfoImageState extends State<CreateRecyclingInfoImage> {
  @override
  void initState() {
    super.initState();
    CreateRecyclingInfo_ViewModel.file = null;
    CreateRecyclingInfo_ViewModel.fileName = "";
  }

  CreateRecyclingInfo_ViewModel vm = CreateRecyclingInfo_ViewModel();
  TextInputType? key;

  get keyboard => key;
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            controller: widget.state.fileField,
            keyboardType: keyboard,
            decoration: const InputDecoration(
                labelText: "Image File ",
                labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            onChanged: (text) => setState(() => ""),
          ),
          ButtonWidget(
              text: 'Select File',
              icon: Icons.attach_file,
              onClicked: () {
                CreateRecyclingInfo_ViewModel.selectFile(widget.state);
                //widget.state.fileField.text=vm.fileName;
              }),
          const SizedBox(height: 20),
          // task != null ? buildUploadStatus(task!) : Container(),
        ]);
  }

  showAlertDialog(BuildContext context, String text) {
    // set up the button
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.pushNamed(context, routes.createRecycleCenterRoute);
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
