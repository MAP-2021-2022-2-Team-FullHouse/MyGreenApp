import 'package:flutter/material.dart';
import 'package:my_green_app/constants/routes_path.dart' as routes;

class ShopNavigationBar extends StatefulWidget {
  const ShopNavigationBar({Key? key}) : super(key: key);

  @override
  State<ShopNavigationBar> createState() =>
      _ShopNavigationBarState();
}

class _ShopNavigationBarState
    extends State<ShopNavigationBar> {
  int currIndex = 3;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currIndex,
      onTap: (index) => setState(() => {
            currIndex = index,
            if (currIndex == 0)
              {Navigator.of(context).pushReplacementNamed(routes.user_rcRoute)}
            else if (currIndex == 2)
              {Navigator.of(context).pushReplacementNamed(routes.homeRoute)}
            else if (currIndex == 3)
              {Navigator.of(context).pushReplacementNamed(routes.shopRoute)}
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
          label: 'Profile',
        ),
      ],
    );
  }
}
