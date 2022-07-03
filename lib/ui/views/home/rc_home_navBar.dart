import 'package:flutter/material.dart';
import 'package:my_green_app/constants/routes_path.dart' as routes;

class RCHomeNavigationBar extends StatefulWidget {
  final int pageNo;
  const RCHomeNavigationBar({Key? key, required this.pageNo}) : super(key: key);

  @override
  State<RCHomeNavigationBar> createState() => _RCHomeNavigationBarState();
}

class _RCHomeNavigationBarState extends State<RCHomeNavigationBar> {
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
              {
                Navigator.of(context)
                    .pushReplacementNamed(routes.recycleCenterAppointmentRoute)
              }
            else if (currIndex == 1)
              {
                Navigator.of(context)
                    .pushReplacementNamed(routes.recycleCenterHomeRoute)
              }
            else if (currIndex == 2)
              {Navigator.of(context).pushReplacementNamed(routes.profileRoute)}
          }),
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.book_online),
          label: 'Appointment',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}
