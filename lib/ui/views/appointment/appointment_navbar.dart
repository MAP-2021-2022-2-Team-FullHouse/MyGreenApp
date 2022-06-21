import 'package:flutter/material.dart';
import 'package:my_green_app/constants/routes_path.dart' as routes;

class AppointmentNavigationBar extends StatefulWidget {
  const AppointmentNavigationBar({Key? key}) : super(key: key);

  @override
  State<AppointmentNavigationBar> createState() =>
      _AppointmentNavigationBarState();
}

class _AppointmentNavigationBarState extends State<AppointmentNavigationBar> {
  int currIndex = 1;
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
              else if(currIndex==1)
              {Navigator.of(context).pushReplacementNamed(routes.appointmentRoute)}
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
          label: 'Profile',
        ),
      ],
    );
  }
}
