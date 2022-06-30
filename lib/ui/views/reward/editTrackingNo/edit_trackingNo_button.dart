
import 'package:flutter/material.dart';
import 'edit_trackingNo_screen.dart';


class EditTrackingNoButton extends StatelessWidget {
  final EditTrackingNoScreenState state;

 const EditTrackingNoButton({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width / 2,
        height: 35,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color.fromARGB(255, 227, 231, 0),
          boxShadow: [
            BoxShadow(
               color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 3,
              offset: const Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: MaterialButton(
            onPressed: () => {state.editTrackingNo()}, child: const Text("Save", style:TextStyle(fontSize: 16))));
  }
}
