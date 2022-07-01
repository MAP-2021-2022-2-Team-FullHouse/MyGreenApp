import 'package:flutter/material.dart';
import 'package:my_green_app/constants/routes_path.dart' as routes;
import 'package:my_green_app/ui/views/recyclinginfo/recyclinginfo_body.dart';
import 'package:my_green_app/ui/views/recyclinginfo/recyclinginfo_viewmodel.dart';

// ignore: use_key_in_widget_constructors
class RecyclingInfoScreenful extends StatefulWidget {
  static Route route() =>
      MaterialPageRoute(builder: (_) => RecyclingInfoScreenful());

  @override
  State<RecyclingInfoScreenful> createState() => RecyclingInfoScreenfulState();
}

class RecyclingInfoScreenfulState extends State<RecyclingInfoScreenful> {
  void onDelete(RecyclingInfoViewmodel viewmodel, String id) async {
    await viewmodel.deleteRecyclingInfo(id);
  }

  Future<String?> getImgUrl(String imgUrl) async {
    RecyclingInfoViewmodel viewmodel = RecyclingInfoViewmodel();
    return await viewmodel.getImgUrl(imgUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: RecyclingInfoBody(state: this));
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
