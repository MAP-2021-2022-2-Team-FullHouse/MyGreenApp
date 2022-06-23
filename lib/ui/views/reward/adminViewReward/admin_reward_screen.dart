import 'package:flutter/material.dart';
import 'admin_view_reward.dart';

class AdminRewardScreen extends StatelessWidget {
  static Route route() =>
      MaterialPageRoute(builder: (_) => const AdminRewardScreen());
  const AdminRewardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        appBar: AdminRewardAppBar(),
        body: AdminRewardBody(),
        //floatingActionButton: const AdminFloat(),
        bottomNavigationBar: AdminRewardNavigationBar(),
      ),
    );
  }
}
