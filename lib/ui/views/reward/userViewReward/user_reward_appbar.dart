import 'package:flutter/material.dart';

class UserRewardAppBar extends StatelessWidget implements PreferredSizeWidget {
  const UserRewardAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(75);

  @override
  Widget build(BuildContext context) {
     return  AppBar(
        elevation: 10,
        toolbarHeight: 100,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(
          'Reward',
          style: TextStyle(color: Colors.black.withOpacity(1.0)),
        ),
        // backgroundColor: Colors.green,
      );
    
  }
}
