import 'package:flutter/material.dart';
import 'package:my_green_app/constants/routes_path.dart' as routes;
import 'package:my_green_app/ui/views/home/home_viewmodel.dart';

class HomeNavigationBar extends StatefulWidget {
  final int pageNo;
  const HomeNavigationBar({Key? key, required this.pageNo}) : super(key: key);

  @override
  State<HomeNavigationBar> createState() => _HomeNavigationBarState();
}

class _HomeNavigationBarState extends State<HomeNavigationBar> {
  HomeViewmodel model = HomeViewmodel();
  var role = HomeViewmodel.getCurrentRole();
  @override
  Widget build(BuildContext context) {
    int currIndex;
    currIndex = widget.pageNo;
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currIndex,
      onTap: (index) => setState(() => {
            currIndex = index,
            if (currIndex == 0)
              {Navigator.of(context).pushReplacementNamed(routes.user_rcRoute)}
            else if (currIndex == 1)
              {
                Navigator.of(context)
                    .pushReplacementNamed(routes.appointmentRoute)

                /* else if (HomeViewmodel.getCurrentRole() == 'Recycle Center')
                  {
                    Navigator.of(context).pushReplacementNamed(
                        routes.recycleCenterAppointmentRoute)
                  } */
              }
            else if (currIndex == 2)
              {Navigator.of(context).pushReplacementNamed(routes.homeRoute)}
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
