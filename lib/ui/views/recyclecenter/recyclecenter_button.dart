import 'package:flutter/material.dart';
import 'package:my_green_app/model/RecycleCenter.dart';
import 'package:my_green_app/ui/views/home/home_screenState.dart';
import 'package:my_green_app/ui/views/home/home_viewmodel.dart';
import 'package:my_green_app/ui/views/recyclecenter/recyclecenter_screenstate.dart';
import 'package:my_green_app/ui/views/recyclecenter/recyclecenter_viewmodel.dart';

class RCListButton extends StatelessWidget {
  final RecycleCenterViewmodel viewmodel;
  final RecycleCenterScreenfulState state;
  final RecycleCenter model;
  const RCListButton(
      {required this.viewmodel, required this.state, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(children: <Widget>[
      ElevatedButton.icon(
        icon: Icon(
          Icons.info_outline,
          size: 18.0,
        ),
        label: Text('Details'),
        onPressed: () async {
          viewmodel.viewRC(context, model.email);
        },
      ),
      SizedBox(
        width: 8,
      ),
      ElevatedButton.icon(
        icon: Icon(
          Icons.edit,
          size: 18.0,
        ),
        label: Text('Edit'),
        onPressed: () async {},
      ),
      SizedBox(
        width: 8,
      ),
      ElevatedButton.icon(
        icon: Icon(
          Icons.delete,
          size: 18.0,
        ),
        label: Text('Delete'),
        onPressed: () async {
          state.onDelete(viewmodel, model.email);
        },
      ),
    ]));
  }
}
