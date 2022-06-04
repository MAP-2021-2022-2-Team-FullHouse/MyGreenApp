import 'package:flutter/material.dart';
import 'package:my_green_app/model/RecycleCenter.dart';
import 'package:my_green_app/ui/views/recyclecenter/recyclecenter_viewmodel.dart';
import 'package:my_green_app/ui/views/recyclecenter/view/view_map.dart';

Widget getViewContainer(context,viewmodel, RecycleCenter rc)
{
    if(RecycleCenterViewmodel.viewAction==true)
    {
      print (RecycleCenterViewmodel.viewAction);
      return buildViewRC(context,viewmodel, rc);
    }
    else 
    {
      return Container();
    }
}
