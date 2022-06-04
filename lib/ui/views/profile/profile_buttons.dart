import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_green_app/model/user.dart';
import 'package:my_green_app/ui/views/profile/profile_edit.dart';
import 'package:my_green_app/ui/views/profile/profile_screen.dart';
import 'package:my_green_app/ui/views/profile/profile_viewmodel.dart';
import 'package:my_green_app/ui/views/recyclecenter/recyclecenter_button.dart';
import 'package:my_green_app/ui/views/recyclecenter/recyclecenter_screenstate.dart'
    as state;
import 'package:my_green_app/ui/views/reward/userViewReward/user_reward_screen.dart';

class ProfileButton extends StatelessWidget {
  final ProfileViewmodel viewmodel;
  final ProfileScreenState state;
  const ProfileButton({required this.viewmodel, required this.state});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
          ElevatedButton.icon(
            icon: Icon(
              Icons.edit,
              size: 20.0,
            ),
            style: ElevatedButton.styleFrom(
              primary: Color.fromRGBO(195, 196, 141, 100), // Background color
            ),
            label: Text('Edit Profile'),
            onPressed: () async {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => EditProfile()),
              );
            },
          ),
          SizedBox(
            width: 20,
          ),
          ElevatedButton.icon(
            icon: Icon(
              Icons.card_giftcard,
              size: 20.0,
            ),
            style: ElevatedButton.styleFrom(
              primary: Color.fromRGBO(195, 196, 141, 100), // Background color
            ),
            label: Text('Redeem Rewards'),
            onPressed: () async {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => UserRewardScreen()),
              );
            },
          ),
        ]));
  }
}
