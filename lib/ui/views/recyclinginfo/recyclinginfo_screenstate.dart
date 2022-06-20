import 'package:flutter/material.dart';
import 'package:my_green_app/constants/routes_path.dart' as routes;
import 'package:my_green_app/ui/views/recyclinginfo/recyclinginfo_body.dart';
import 'package:my_green_app/ui/views/recyclinginfo/recyclinginfo_viewmodel.dart';

class RecyclingInfoScreenful extends StatefulWidget {
  static Route route() =>
      MaterialPageRoute(builder: (_) => RecyclingInfoScreenful());

  @override
  State<RecyclingInfoScreenful> createState() => RecyclingInfoScreenfulState();
}

class RecyclingInfoScreenfulState extends State<RecyclingInfoScreenful> {
  void onDelete(RecyclingInfoViewmodel viewmodel, String id) async {
    //dynamic result;
    await viewmodel.deleteRecyclingInfo(id);
  }

  Future<String?> getImgUrl(String imgUrl) async {
    RecyclingInfoViewmodel viewmodel = new RecyclingInfoViewmodel();
    return await viewmodel.getImgUrl(imgUrl);
  }

/*
  Widget getViewContainer(context,RecycleCenterViewmodel viewmodel)
  {
    if(viewmodel.isViewAction==true)
    {
      print (RecycleCenterViewmodel.viewAction);
      return ViewMap(
              viewmodel: RecycleCenterViewmodel(),
              state: this,
              model: RecycleCenterViewmodel.recycleCenter);
    }
    else 
    {
      return Container();
    }
  }*/
/*
  void onView(RecycleCenterViewmodel viewmodel, String email)
  async {
    await viewmodel.viewRC(email);
    
  }
  void onCloseView(RecycleCenterViewmodel viewmodel)
  {
    viewmodel.closeViewRC();
    
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: RecyclingInfoBody(state: this));
  }
}

showAlertDialog(BuildContext context, String text) {
  // set up the button
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.pushNamed(context, routes.loginRoute);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Error"),
    content: Text(text),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
