import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_green_app/ui/views/recyclinginfo/recyclinginfo_button.dart';
import 'package:my_green_app/ui/views/recyclinginfo/recyclinginfo_screenstate.dart';
import 'package:intl/intl.dart';
import '../../../model/recycling_info.dart';
import 'package:my_green_app/ui/views/recyclinginfo/recyclinginfo_viewmodel.dart'
    as rlviewmodel;

RecyclingInfoScreenfulState state = new RecyclingInfoScreenfulState();

Widget buildRecyclingInfo(RecyclingInfo recyclingInfo) => ListTile(
      leading: CircleAvatar(
        child: FutureBuilder(
          future: state.getImgUrl("recyclingInfo/" + recyclingInfo.image),
          builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
            bool error = snapshot.data == null;
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
          Container(child: Row()),
          RecyclingInfoListButton(
            viewmodel: rlviewmodel.RecyclingInfoViewmodel(),
            model: recyclingInfo,
            state: RecyclingInfoScreenfulState(),
          )
        ],
      ),
    );

Widget buildImage(String? data) {
  return Container(
    child: Material(
      color: Colors.transparent,
      child: Ink.image(
        image: NetworkImage(data.toString()),
        fit: BoxFit.cover,
        width: 128,
        height: 128,
        child: InkWell(),
      ),
    ),
  );
}
