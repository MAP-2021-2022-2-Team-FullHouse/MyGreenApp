import 'package:flutter/material.dart';
import 'package:my_green_app/ui/views/recyclinginfo/recyclinginfo_appbar.dart';
import 'package:my_green_app/ui/views/recyclinginfo/recyclinginfo_body.dart';
import 'package:my_green_app/ui/views/recyclinginfo/recyclinginfo_navbar.dart';
import 'package:my_green_app/ui/views/recyclinginfo/recyclinginfo_screenstate.dart';

class RecyclingInfoScreen extends StatelessWidget {
  static Route route() =>
      MaterialPageRoute(builder: (_) => RecyclingInfoScreen());
  const RecyclingInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const RecyclingInfoAppBar(),
        body: RecyclingInfoScreenful(),
        //floatingActionButton: const AdminFloat(),
        bottomNavigationBar: RecyclingInfoNavigationBar(),
      ),
    );
  }
}
