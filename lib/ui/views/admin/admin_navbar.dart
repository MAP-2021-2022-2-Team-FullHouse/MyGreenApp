import 'package:flutter/material.dart';
import 'package:my_green_app/constants/routes_path.dart' as routes;

class AdminNavigationBar extends StatefulWidget {
  const AdminNavigationBar({Key? key}) : super(key: key);

  @override
  State<AdminNavigationBar> createState() => _AdminNavigationBarState();
}

class _AdminNavigationBarState extends State<AdminNavigationBar> {
  int currIndex = 2;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currIndex,
      onTap: (index) => setState(() => {
            currIndex = index,
            if (currIndex == 0)
              {Navigator.of(context).pushNamed(routes.recyclingInfoRoute)}
            else if (currIndex == 1)
              {Navigator.of(context).pushNamed(routes.rcRoute)}
            else if (currIndex == 4)
              {Navigator.of(context).pushNamed(routes.profileRoute)}
          }),
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.article),
          label: 'Info',
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
