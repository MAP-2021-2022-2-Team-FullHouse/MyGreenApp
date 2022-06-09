import 'package:flutter/material.dart';
import 'user_view_reward.dart';

class UserRewardScreen extends StatelessWidget {
  static Route route() =>
      MaterialPageRoute(builder: (_) => const UserRewardScreen());
  const UserRewardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        appBar: UserRewardAppBar(),
        body: UserRewardBody(),
        //floatingActionButton: const AdminFloat(),
        bottomNavigationBar: UserRewardNavigationBar(),
      ),
    );
  }
}
