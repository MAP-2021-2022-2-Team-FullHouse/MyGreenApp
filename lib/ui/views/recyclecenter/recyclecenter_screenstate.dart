import 'package:flutter/material.dart';
import 'package:my_green_app/constants/routes_path.dart' as routes;
import 'recyclecenter.dart';

class RecycleCenterScreenful extends StatefulWidget {
  static Route route() =>
      MaterialPageRoute(builder: (_) => RecycleCenterScreenful());

  @override
  State<RecycleCenterScreenful> createState() => RecycleCenterScreenfulState();
}

class RecycleCenterScreenfulState extends State<RecycleCenterScreenful> {
  void onDelete(RecycleCenterViewmodel viewmodel, String email) async {
    //dynamic result;
    await viewmodel.deleteCenter(email);
  }

  Widget getViewContainer(context, RecycleCenterViewmodel viewmodel) {
    if (viewmodel.isViewAction == true) {
      //print(RecycleCenterViewmodel.viewAction);
      return ViewMap(
          viewmodel: RecycleCenterViewmodel(),
          state: this,
          model: RecycleCenterViewmodel.recycleCenter);
    } else {
      return Container();
    }
  }

  Future<String?> getImgUrl(String imgUrl) async {
    RecycleCenterViewmodel viewmodel = RecycleCenterViewmodel();
    return await viewmodel.getImgUrl(imgUrl);
  }

  void onView(RecycleCenterViewmodel viewmodel, String email) async {
    await viewmodel.viewRC(email);
  }

  void onCloseView(RecycleCenterViewmodel viewmodel) {
    viewmodel.closeViewRC();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: RecycleCenterBody(state: this));
  }
}

showAlertDialog(BuildContext context, String text) {
  // set up the button
  Widget okButton = TextButton(
    child: const Text("OK"),
    onPressed: () {
      Navigator.pushNamed(context, routes.loginRoute);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Error"),
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
