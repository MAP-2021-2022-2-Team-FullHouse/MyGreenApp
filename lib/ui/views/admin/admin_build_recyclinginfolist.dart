import 'package:flutter/material.dart';
import 'package:my_green_app/model/recycling_info.dart';
import 'package:my_green_app/ui/views/admin/admin_viewmodel.dart';
import 'package:intl/intl.dart';
import 'package:my_green_app/ui/views/admin/view/viewrecyclinginfo_screen.dart';

// ignore: must_be_immutable
class BuildRecyclingInfoList extends StatelessWidget {
  final List<RecyclingInfo> recyclingInfoList;
  final int index;
  AdminViewmodel viewmodel = AdminViewmodel();

  BuildRecyclingInfoList(
      {super.key, required this.recyclingInfoList, required this.index});

  @override
  Widget build(BuildContext context) {
    return Card(
        color: const Color.fromARGB(156, 179, 242, 208),
        child: ListTile(
          leading: SizedBox.square(
            child: FutureBuilder(
              future: viewmodel
                  .getImgUrl("recyclingInfo/${recyclingInfoList[index].image}"),
              builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
                return Container(
                  child: buildImage(snapshot.data),
                );
              },
            ),
          ),
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ViewRecyclingInfoScreen(
                infoId: recyclingInfoList[index].infoId),
          )),
          //ViewRecyclingInfoScreen(infoId: recyclingInfo.infoId),
          title: Text(recyclingInfoList[index].title),
          subtitle: Row(
            children: <Widget>[
              const Icon(Icons.date_range),
              Text(DateFormat('yyyy-MM-dd')
                  .format(recyclingInfoList[index].createdDate.toDate())),
              Row(),
            ],
          ),
        ));
  }
}

Widget buildImage(String? data) {
  return Material(
    color: Colors.transparent,
    child: Ink.image(
      image: NetworkImage(data.toString()),
      fit: BoxFit.fill,
      width: 125,
      child: const InkWell(),
    ),
  );
}
