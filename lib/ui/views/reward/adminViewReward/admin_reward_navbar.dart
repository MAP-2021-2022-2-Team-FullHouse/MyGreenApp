import 'package:flutter/material.dart';
import 'package:my_green_app/constants/routes_path.dart' as routes;

class AdminRewardNavigationBar extends StatefulWidget {
  const AdminRewardNavigationBar({Key? key}) : super(key: key);

  @override
  State<AdminRewardNavigationBar> createState() =>
      _AdminRewardNavigationBarState();
}

class _AdminRewardNavigationBarState
    extends State<AdminRewardNavigationBar> {
  int currIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currIndex,
      onTap: (index) => setState(() => {
            currIndex = index,

            if (currIndex == 2)
              {Navigator.of(context).pushNamed(routes.adminRoute)}
            else if (currIndex == 4)
              {Navigator.of(context).pushReplacementNamed(routes.profileRoute)}
              else if (currIndex == 0)
              {Navigator.of(context).pushReplacementNamed(routes.adminRewardRoute)}
               else if (currIndex == 1)
              {Navigator.of(context).pushReplacementNamed(routes.rcRoute)}
          }),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.card_giftcard),
          label: 'Reward',
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
          label: 'Admin',
        ),
      ],
    );
  }
}
