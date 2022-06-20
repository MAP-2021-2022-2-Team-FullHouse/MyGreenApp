import 'package:flutter/material.dart';
import 'package:my_green_app/model/recycling_info.dart';
import 'package:my_green_app/ui/views/recyclinginfo/recyclinginfo_screenstate.dart';
import 'package:my_green_app/ui/views/recyclinginfo/recyclinginfo_viewmodel.dart';
//import 'ditRecycleCenter/EditRecycleCenter_Screen.dart';
import 'package:my_green_app/ui/views/recyclinginfo/view/viewrecyclinginfo_screen.dart';
import 'package:my_green_app/constants/routes_path.dart' as routes;

class RecyclingInfoListButton extends StatelessWidget {
  final RecyclingInfoViewmodel viewmodel;
  final RecyclingInfoScreenfulState state;
  final RecyclingInfo model;
  const RecyclingInfoListButton(
      {required this.viewmodel, required this.state, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(children: <Widget>[
      ElevatedButton.icon(
        icon: Icon(
          Icons.preview_outlined, 
          size: 18.0,
        ),
        label: Text('View'),
        onPressed: () async {
          //state.onView(viewmodel, model.email);
          //Navigator.of(context).pushNamed(routes.rcRoute);
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                ViewRecyclingInfoScreen(infoId: model.infoId),
          ));
        },
      ),
      const SizedBox(
        width: 8,
      ),
      ElevatedButton.icon(
        icon: Icon(
          Icons.edit,
          size: 18.0,
        ),
        label: Text('Edit'),
        onPressed: () async {
          //Navigator.of(context).push(MaterialPageRoute(
          //builder: (context) =>) );
          Navigator.of(context).pushNamed(routes.recyclingInfoRoute);
        },
      ),
      const SizedBox(
        width: 8,
      ),
      ElevatedButton.icon(
        icon: Icon(
          Icons.delete,
          size: 18.0,
        ),
        label: Text('Delete'),
        onPressed: () async {
          state.onDelete(viewmodel, model.infoId);
        },
      ),
    ]));
  }
}
