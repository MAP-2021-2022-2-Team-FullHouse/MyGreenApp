import 'package:flutter/material.dart';
import 'package:my_green_app/constants/routes_path.dart' as routes;

class RecycleCenterNavigationBar extends StatefulWidget {
  const RecycleCenterNavigationBar({Key? key}) : super(key: key);

  @override
  State<RecycleCenterNavigationBar> createState() =>
      _RecycleCenterNavigationBarState();
}

class _RecycleCenterNavigationBarState
    extends State<RecycleCenterNavigationBar> {
  int currIndex = 1;
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
          }),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
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
          label: 'Admin',
        ),
      ],
    );
  }
}
