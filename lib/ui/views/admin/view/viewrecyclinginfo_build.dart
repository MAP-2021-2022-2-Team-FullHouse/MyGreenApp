import 'package:flutter/material.dart';
import 'viewrecyclinginfo_screen.dart';
import 'package:my_green_app/model/recycling_info.dart';
import 'package:intl/intl.dart';

List<Widget> buildRecyclingInfo(
        ViewRecyclingInfoScreenState state, RecyclingInfo rl) =>
    [
      Text(
        rl.title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        textAlign: TextAlign.left,
      ),
      const SizedBox(
        height: 10,
      ),
      FutureBuilder(
        future: state.getImgUrl("recyclingInfo/${rl.image}"),
        builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
          return Container(
            child: buildImage(snapshot.data),
          );
        },
      ),
      const SizedBox(
        height: 100,
      ),
      Text(
        DateFormat('yyyy-MM-dd').format(rl.createdDate.toDate()),
        textAlign: TextAlign.left,
      ),
      const SizedBox(
        height: 5.0,
      ),
      Text(rl.content),
      const SizedBox(
        height: 10.0,
      ),
    ];

Widget buildImage(String? data) {
  return Material(
    color: Colors.transparent,
    child: Ink.image(
      image: NetworkImage(data.toString()),
      fit: BoxFit.fill,
      width: 300,
      height: 150,
      child: const InkWell(),
    ),
  );
}
