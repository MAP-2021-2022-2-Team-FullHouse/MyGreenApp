import 'package:flutter/material.dart';
import 'package:my_green_app/constants/routes_path.dart' as routes;
import 'package:my_green_app/constants/routes_path.dart';
import 'package:my_green_app/ui/views/appointment/rc_view/rc_appointment_screen.dart';

class RecycleCenterAppointmentNavigationBar extends StatefulWidget {
  const RecycleCenterAppointmentNavigationBar({Key? key}) : super(key: key);

  @override
  State<RecycleCenterAppointmentNavigationBar> createState() =>
      _RecycleCenterAppointmentNavigationBarState();
}

class _RecycleCenterAppointmentNavigationBarState
    extends State<RecycleCenterAppointmentNavigationBar> {
  int currIndex = 1;
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
            else if (currIndex == 1)
              {
                Navigator.of(context)
                    .pushNamed(routes.recycleCenterAppointmentRoute)
              }
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
