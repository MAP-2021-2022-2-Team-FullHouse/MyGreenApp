import 'package:flutter/material.dart';
import 'package:my_green_app/model/listing.dart';

import '../../../../model/Appointment.dart';

class ShopItem extends StatelessWidget {
  final Listing post;
  //final Function onDeleteItem;
  const ShopItem({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: const EdgeInsets.only(top: 20),
      alignment: Alignment.center,
      child: Row(
        children: <Widget>[
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Text(post.category),
          )),
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {},
          ),
        ],
      ),
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 172, 155, 155),
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(blurRadius: 8, color: Colors.grey, spreadRadius: 3)
          ]),
    );
  }
}
