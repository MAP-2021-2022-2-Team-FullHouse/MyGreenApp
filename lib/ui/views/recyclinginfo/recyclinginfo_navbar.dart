import 'package:flutter/material.dart';
import 'package:my_green_app/constants/routes_path.dart' as routes;

class RecyclingInfoNavigationBar extends StatefulWidget {
  const RecyclingInfoNavigationBar({Key? key}) : super(key: key);

  @override
  State<RecyclingInfoNavigationBar> createState() =>
      _RecyclingInfoNavigationBarState();
}

class _RecyclingInfoNavigationBarState
    extends State<RecyclingInfoNavigationBar> {
  int currIndex = 3;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currIndex,
      onTap: (index) => setState(() => {
            currIndex = index,
            if (currIndex == 1)
              {Navigator.of(context).pushNamed(routes.rcRoute)}
            else if (currIndex == 0)
              {Navigator.of(context).pushNamed(routes.adminRewardRoute)}
            else if (currIndex == 3)
              {Navigator.of(context).pushNamed(routes.recyclingInfoRoute)}
            else if (currIndex == 2)
              {Navigator.of(context).pushNamed(routes.adminRoute)}
          }),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.redeem),
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
          icon: Icon(Icons.article),
          label: 'Info',
        ),
      ],
    );
  }
}
