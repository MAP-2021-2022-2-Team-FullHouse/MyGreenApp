import 'package:flutter/material.dart';
import 'package:my_green_app/constants/routes_path.dart' as routes;

class UserRewardNavigationBar extends StatefulWidget {
  const UserRewardNavigationBar({Key? key}) : super(key: key);

  @override
  State<UserRewardNavigationBar> createState() =>
      _UserRewardNavigationBarState();
}

class _UserRewardNavigationBarState
    extends State<UserRewardNavigationBar> {
  int currIndex = 4;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currIndex,
      onTap: (index) => setState(() => {
            currIndex = index,
            if (currIndex == 2)
              {Navigator.of(context).pushNamed(routes.homeRoute)}
            else if (currIndex == 4)
              {Navigator.of(context).pushReplacementNamed(routes.profileRoute)}
              else if (currIndex == 0)
              {Navigator.of(context).pushReplacementNamed(routes.user_rcRoute)}
          }),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.card_giftcard),
          label: 'Map',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.recycling),
          label: 'Recycle',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.store),
          label: 'Shop',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}
