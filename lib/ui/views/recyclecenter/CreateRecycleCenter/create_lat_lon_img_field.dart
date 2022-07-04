
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:my_green_app/constants/routes_path.dart' as routes;
import 'create_recycle_center.dart';


class CreateLatLon extends StatefulWidget {
  final CreateRecycleCenterScreenState state;
// const CreateLatLon({Key? key, required this.state}) : super(key: key);

  const CreateLatLon({Key? key, required this.state}) : super(key: key);
  // CreateLatLon(CreateRecycleCenterScreenState _state){
  //   this._state=_state;
  // }

  @override
  State<CreateLatLon> createState() => _CreateLatLonState();
}

class _CreateLatLonState extends State<CreateLatLon> {
  @override
  void initState() {
    super.initState();
    CreateRecycleCenter_ViewModel.file = null;
    CreateRecycleCenter_ViewModel.fileName = "";
  }

  CreateRecycleCenter_ViewModel vm = CreateRecycleCenter_ViewModel();
  // UploadTask? task;
 
  // late var filename="no file selected";
  // var latField=TextEditingController();
  // var lonField=TextEditingController();
  // var fileField=TextEditingController();
  
  TextInputType? key;

  get keyboard => key;
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            controller: widget.state.latField,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                labelText: "Latitude: ",
                errorText: errorLat,
                labelStyle: const TextStyle(color: Colors.black, fontSize: 12)),
            onChanged: (text) => setState(() => ""),
          ),
          TextFormField(
            controller: widget.state.lonField,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                labelText: "Longitude: ",
                errorText: errorLon,
                labelStyle: const TextStyle(color: Colors.black, fontSize: 12)),
            onChanged: (text) => setState(() => ""),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: const Color.fromRGBO(29, 194, 95, 1),
                minimumSize: const Size.fromHeight(50),
              ),
              onPressed: () async {
         

                // widget.state.latField.text = "0";
                // widget.state.lonField.text =
                    // "103.644991"; for testing in emulator
                Position p = await CreateRecycleCenter_ViewModel.getPosition();
                String lat = p.latitude.toString(); //set realtime latitude
                String lon = p.longitude.toString(); //set realtime longtitude
                widget.state.latField.text = lat; //set lat textfield
                widget.state.lonField.text = lon; //set lon textfield
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.map, size: 28),
                  SizedBox(width: 16),
                  Text(
                    "Get Location",
                    style: TextStyle(fontSize: 22, color: Colors.white),
                  ),
                ],
              )),
          const SizedBox(height: 8),
          TextFormField(
            controller: widget.state.fileField,
            keyboardType: keyboard,
            decoration: const InputDecoration(
                labelText: "Image File: ",
                // errorText: errorLon,
                labelStyle: TextStyle(color: Colors.black, fontSize: 12)),
            onChanged: (text) => setState(() => ""),
          ),
          ButtonWidget(
              text: 'Select File',
              icon: Icons.attach_file,
              onClicked: () {
                CreateRecycleCenter_ViewModel.selectFile(widget.state);
                //widget.state.fileField.text=vm.fileName;
              }),

          // SizedBox(height: 8),

          //   ButtonWidget(
          //     text: 'Upload File',
          //     icon: Icons.cloud_upload_outlined,
          //     onClicked: (){
          //       CreateRecycleCenter_ViewModel.uploadFile();
          //       },
          //   ),
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

  String? get errorLat {
    final String text = widget.state.latField.text;
//^\d+[\.\,]\d+\$
    if (text == "") {
      return 'This field is required.';
    }

    RegExp regex = RegExp(r'^[0-9]+(\.[0-9]+)?$');
    String match = text;
    if (!regex.hasMatch(match)) {
      return 'Invalid latitude format';
    }
    return null;
  }

  String? get errorLon {
    final String text = widget.state.lonField.text;

    if (text == "") {
      return 'This field is required.';
    }
    RegExp regex = RegExp(r'^[0-9]+(\.[0-9]+)?$');
    String match = text;
    if (!regex.hasMatch(match)) {
      return 'Invalid longitude format';
    }
    return null;
  }
}
