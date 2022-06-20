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
  int currIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currIndex,
      onTap: (index) => setState(() => {
            currIndex = index,
            if (currIndex == 1)
              {Navigator.of(context).pushNamed(routes.rcRoute)}
            else if (currIndex == 4)
              {Navigator.of(context).pushNamed(routes.profileRoute)}
          }),
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.article),
          label: 'Recycling Info',
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
