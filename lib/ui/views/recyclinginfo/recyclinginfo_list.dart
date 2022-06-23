import 'package:flutter/material.dart';
import 'package:my_green_app/ui/views/recyclinginfo/recyclinginfo_button.dart';
import 'package:my_green_app/ui/views/recyclinginfo/recyclinginfo_screenstate.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import '../../../model/recycling_info.dart';
import 'package:my_green_app/ui/views/recyclinginfo/recyclinginfo_viewmodel.dart'
    as rlviewmodel;

RecyclingInfoScreenfulState state = RecyclingInfoScreenfulState();

Widget buildRecyclingInfo(RecyclingInfo recyclingInfo) => ListTile(
      leading: CircleAvatar(
        child: FutureBuilder(
          future: state.getImgUrl("recyclingInfo/${recyclingInfo.image}"),
          builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
            return Container(
              child: buildImage(snapshot.data),
            );
          },
        ),
      ),
      title: Text(recyclingInfo.title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(DateFormat('yyyy-MM-dd')
              .format(recyclingInfo.createdDate.toDate())),
          Row(),
          RecyclingInfoListButton(
            viewmodel: rlviewmodel.RecyclingInfoViewmodel(),
            model: recyclingInfo,
            state: RecyclingInfoScreenfulState(),
          )
        ],
      ),
    );

Widget buildImage(String? data) {
  return Material(
    color: Colors.transparent,
    child: Ink.image(
      image: NetworkImage(data.toString()),
      fit: BoxFit.cover,
      width: 128,
      height: 128,
      child: const InkWell(),
    ),
  );
}
