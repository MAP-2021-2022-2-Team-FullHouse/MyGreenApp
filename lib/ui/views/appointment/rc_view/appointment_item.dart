import 'package:flutter/material.dart';

import '../../../../model/Appointment.dart';

class AppointmentItem extends StatelessWidget {
  final Appointment post;
  //final Function onDeleteItem;
  const AppointmentItem({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: const EdgeInsets.only(top: 20),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: const [
            BoxShadow(blurRadius: 8, color: Colors.grey, spreadRadius: 3)
          ]),
      child: Row(
        children: <Widget>[
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Text(post.rcName),
          )),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
