import 'package:flutter/material.dart';
import 'package:my_green_app/constants/routes_path.dart' as routes;


class RCNavigationBar extends StatefulWidget {
  const RCNavigationBar({Key? key}) : super(key: key);

  @override
  State<RCNavigationBar> createState() => _RCNavigationBarState();
}

class _RCNavigationBarState extends State<RCNavigationBar> {
  int currIndex = 2;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currIndex,
      onTap: (index) => setState(() => {
            currIndex = index,
            if (currIndex == 2)
              {Navigator.of(context).pushNamed(routes.adminRoute)}
          }),
      items: [
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
