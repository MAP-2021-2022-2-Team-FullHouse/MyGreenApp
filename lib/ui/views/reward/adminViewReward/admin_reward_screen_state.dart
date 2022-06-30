
import 'package:flutter/material.dart';
import 'package:my_green_app/constants/routes_path.dart' as routes;
import 'admin_view_reward.dart';


class AdminRewardScreenful extends StatefulWidget {
  const AdminRewardScreenful({Key? key}) : super(key: key);

  static Route route() =>
      MaterialPageRoute(builder: (_) =>const AdminRewardScreenful());

  @override
  State<AdminRewardScreenful> createState() => AdminRewardScreenfulState();
}

class AdminRewardScreenfulState extends State<AdminRewardScreenful> {
  void onDelete(AdminRewardViewmodel viewmodel, String docID) async {
    //dynamic result;
    await viewmodel.deleteReward(docID);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: AdminRewardBody());
  }
  Future<String?> getImgUrl(String imgUrl, AdminRewardViewmodel viewmodel) async {
    print(viewmodel.getImgUrl(imgUrl));
    return await viewmodel.getImgUrl(imgUrl);
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
