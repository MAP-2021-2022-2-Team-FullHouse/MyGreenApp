import 'package:flutter/material.dart';
import 'viewrecyclinginfo_screen.dart';
import 'viewrecyclinginfo_viewmodel.dart';
import 'package:my_green_app/model/recycling_info.dart';

List<Widget> buildRecyclingInfo(
        ViewRecyclingInfoScreenState state, RecyclingInfo rl) =>
    [
      Text(rl.title),
      FutureBuilder(
        future: state.getImgUrl("recyclingInfo/" + rl.image),
        builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
          bool error = snapshot.data == null;
          return Container(
            child: buildImage(snapshot.data),
          );
        },
      ),
      Text(rl.content),
      const SizedBox(
        height: 10.0,
      ),
    ];

Widget buildImage(String? data) {
  return Container(
    child: Material(
      color: Colors.transparent,
      child: Ink.image(
        image: NetworkImage(data.toString()),
        fit: BoxFit.cover,
        width: 200,
        height: 150,
        child: InkWell(),
      ),
    ),
  );
}
